require 'pry'

class Waiter
    attr_accessor :name, :yrs_experience

    @@all = []

    def initialize(name, yrs_experience)
        @name = name
        @yrs_experience = yrs_experience
        @@all << self
    end

    def self.all
        @@all
    end

    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end

    def meals
        Meal.all.select do |meal|
            meal.waiter == self 
        end
    end

    def average_tip
        total_tip = 0
        meals.each {|meal| total_tip += meal.tip}
        average = total_tip / meals.length
    end

    def best_tipper
        best_tipped_meal = meals.max do |meal_a, meal_b|
            meal_a.tip <=> meal_b.tip
        end
        best_tipped_meal.customer
    end

    def worst_tipper
        worst_tipped_meal = meals.min do |meal_a, meal_b|
            meal_a.tip <=> meal_b.tip
        end
        worst_tipped_meal.customer
    end

    def customers
        meals.map do |meal|
            meal.customer
        end
    end

    def frequent_customer
        frequency = Hash.new(0)
        customers.each { |meal| frequency[meal] += 1 }
        frequency.sort_by {|meal, number| number}.last[0]
    end

    def self.most_experienced
        self.all.max do |a, b|
            a.yrs_experience <=> b.yrs_experience
        end.average_tip
    end

    def self.least_experienced
        self.all.min do |a, b|
            a.yrs_experience <=> b.yrs_experience
        end.average_tip
    end

end
class Adder
    def push(n)
	@args ||=[]
	@args << n
    end
    def add
	@sum = 0
	@args.each do |arg|
	    @sum += arg
	end
	@sum
    end
end

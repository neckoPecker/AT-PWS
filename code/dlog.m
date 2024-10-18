% dlog = Debug Log

function [ ] = dlog (type, string, description)

if ~exist('description', 'var')
    description = "";
end

switch type
    case "info"
        fprintf(strcat("[INFO]:\t\t", string, "\n"));
        fprintf(description)
        fprintf("\n")
    case "error"
        fprintf("--------------------------------------------------------\n")
        fprintf(strcat("\t !!![ERROR]: ", string, "!!!\n\n"));
        fprintf(description)
        fprintf("\n--------------------------------------------------------\n")
    otherwise
        fprintf(string);
end

end
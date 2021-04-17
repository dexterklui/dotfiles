# Glubal ycm extra conf file for compile flags

c_warn = ['-Wall', '-Wextra', '-Werror']
c_flags = ['-pedantic-errors']

def Settings( **kwargs ):
    if kwargs['filename'].endswith('.c'):
        flags = ['-x', 'c', '-std=c11'] + c_warn + c_flags
        return {'flags': flags}
    if kwargs['filename'].endswith('.cpp') \
            or kwargs['filename'].endswith('.h'):
        flags = ['-x', 'c++', '-std=c++11'] + c_warn + c_flags
        return {'flags': flags}
    return {'flags': []}


# vi: ft=python

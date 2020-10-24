class Gpio < ApplicationRecord
  GPIO = [
      [{ color: '#DAA01D', num: '3v3' }, { color: 'red',     num: '5v0' }],
      [{ color: '#4792FF', num: 2     }, { color: 'red',     num: '5v0' }],
      [{ color: '#4792FF', num: 3     }, { color: '#000000', num: 'GND' }],
      [{ color: '#24AF54', num: 4     }, { color: '#6C42AA', num: 14    }],
      [{ color: '#000000', num: 'GND' }, { color: '#6C42AA', num: 15    }],
      [{ color: '#24AF54', num: 17    }, { color: '#24AF54', num: 18    }],
      [{ color: '#24AF54', num: 27    }, { color: '#000000', num: 'GND' }],
      [{ color: '#24AF54', num: 22    }, { color: '#24AF54', num: 23    }],
      [{ color: '#DAA01D', num: '3v3' }, { color: '#24AF54', num: 24    }],
      [{ color: '#AA37A1', num: 10    }, { color: '#000000', num: 'GND' }],
      [{ color: '#AA37A1', num: 9     }, { color: '#24AF54', num: 25    }],
      [{ color: '#AA37A1', num: 11    }, { color: '#AA37A1', num: 8     }],
      [{ color: '#000000', num: 'GND' }, { color: '#AA37A1', num: 7     }],
      [{ color: '#4792FF', num: 0     }, { color: '#4792FF', num: 1     }],
      [{ color: '#24AF54', num: 5     }, { color: '#000000', num: 'GND' }],
      [{ color: '#24AF54', num: 6     }, { color: '#24AF54', num: 12    }],
      [{ color: '#24AF54', num: 13    }, { color: '#000000', num: 'GND' }],
      [{ color: '#AA37A1', num: 19    }, { color: '#24AF54', num: 16    }],
      [{ color: '#24AF54', num: 26    }, { color: '#AA37A1', num: 20    }],
      [{ color: '#000000', num: 'GND' }, { color: '#AA37A1', num: 21    }]
  ]
end

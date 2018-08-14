From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 14 Aug 2018 13:20:14 +0000
Subject: Re: console device on s390 systems
Message-Id: <f147f72e-1b41-639a-1db6-0c240585ce3c@roeck-us.net>
In-Reply-To: <20180814125219.GA2232@osiris>
References: <20180814125219.GA2232@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 08/14/2018 05:52 AM, Heiko Carstens wrote:
> On Mon, Aug 13, 2018 at 08:18:36PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> when booting s390 images in qemu, I notice the following:
>>
>> / # cat /proc/consoles
>> ttyS1                -W- (EC p  )    4:65
>> / # ls /dev/ttyS*
>> ls: /dev/ttyS*: No such file or directory
>> / #
>> / # dmesg | grep tty
>> console [ttyS1] enabled
>>
>> In reality, the console is at /dev/ttysclp0.
>>
>> Any idea what is going on ?
> 
> This is expected behavior. The sclp vt220 driver provides two types of
> Linux devices: a console device and a tty device.
> 
> /proc/consoles only lists console device names as used by the console=
> kernel parameter. The character device node associated with the console is
> always /dev/console.
> 
> tty device nodes are created based on tty devices names. Typically console
> and tty device names are the same, but in case of the sclp console device
> driver different names are used for historical reasons.
> 

Interesting. Thanks a lot for the information.

Guenter

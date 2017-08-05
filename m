Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 5 Aug 2017 09:44:45 +0800 (CST)
From: sohu0106 <sohu0106@126.com>
Subject: Re:Re: drivers/s390/char/keyboard.c NULL pointer reference
In-Reply-To: <20170804092608.GB3278@osiris>
References: <3b10f99f.aa01.15da8632dec.Coremail.sohu0106@126.com>
 <20170804092608.GB3278@osiris>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Message-ID: <5ad3af06.c08.15db010eb92.Coremail.sohu0106@126.com>
Sender: linux-kernel-owner@vger.kernel.org
Content-Transfer-Encoding: 8bit
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



I don't understand a bit,My idea is 

in userland

fd=open("tty3270",O_RDONLY)
...
ret=ioctl(fd,KDGKBDIACR,NULL)
...

then here 
drivers/s390/char/keyboard.c
477 
case KDGKBDIACR:
	{
		struct kbdiacrs __user *a = argp;
		struct kbdiacr diacr;
		int i;
		
		//a is NULL,a->kb_cnt will crash
		if (put_user(kbd->accent_table_size, &a->kb_cnt))




At 2017-08-04 17:26:08, "Heiko Carstens" <heiko.carstens@de.ibm.com> wrote:
>On Thu, Aug 03, 2017 at 09:57:38PM +0800, sohu0106 wrote:
>> 
>> 
>> Local users able to send the NULL arg argument to kbd_ioctl(), which could cause kernel crash
>> 
>> 
>> 
>> 
>> diff --git a/keyboard.c 
>> b/keyboard.c
>> index ba0e4f9..3ec16b1 100644
>> --- a/keyboard.c
>> +++ b/keyboard.c
>> @@ -456,6 +456,8 @@ int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
>>         int perm;
>>  
>>         argp = (void __user *)arg;
>> +       if( !argp )
>> +               return -EFAULT;
>
>This doesn't make sense as well. All uaccess functions are able to handle
>NULL pointers within user space.
>

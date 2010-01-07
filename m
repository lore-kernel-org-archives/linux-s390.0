From: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: next Jan 6: drivers/s390/char/defkeymap build break
Date: Thu, 07 Jan 2010 11:33:51 +0530
Message-ID: <4B457947.2040004@in.ibm.com>
References: <20100106180342.43844983.sfr@canb.auug.org.au> <4B445470.8010402@in.ibm.com> <4B44B6F8.9070209@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4B44B6F8.9070209@windriver.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Jason Wessel wrote:
> Sachin Sant wrote:
>   
>> Today's next fails to build on s390 with
>>
>>  CC      drivers/s390/char/defkeymap.o
>> drivers/s390/char/defkeymap.c:30: error: static declaration of 'shift_map' follows non-static declaration
>> include/linux/keyboard.h:31: error: previous declaration of 'shift_map' was here
>> drivers/s390/char/defkeymap.c:49: error: static declaration of 'ctrl_map' follows non-static declaration
>> include/linux/keyboard.h:32: error: previous declaration of 'ctrl_map' was here
>> make[2]: *** [drivers/s390/char/defkeymap.o] Error 1
>> make[1]: *** [drivers/s390/char] Error 2
>>
>> Probable cause could be commit 91570de..
>> kgdboc,keyboard: Keyboard driver for kdb with kgdb
>>
>> Thanks
>> -Sachin
>>
>>   
>>     
> I had patched the include/linux/keyboard.h originally to expose the
> definition which was already a global symbol.  It turns out the
> kdb_keyboard.c implementation should not be accessing shift_map[]
> directly.  It is accessed through a pointer to the data found in key_maps[].
>
> I folded in a change to this patch to not modify
> include/linux/keyboard.h and to fix the kdb keyboard code to use key_maps[].
>
> Hopefully that fixes the problem.  Attached is the folded patch, which
> reverts include/linux/keyboard.h to be unmodified by the kdb series.
>   
Yup that works. Thanks


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------

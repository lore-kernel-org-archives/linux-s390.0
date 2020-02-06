Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay.sw.ru ([185.231.240.75]:39752 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgBFGLV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:21 -0500
Subject: Re: [PATCH 0/1] s390: seq_file .next functions should increase
 position index
References: <8b5e38e4-ca07-b3c7-bdb7-4f4c3ad94233@virtuozzo.com>
 <1b957299-9c5d-9423-3982-10da697b3fb1@de.ibm.com>
From: Vasily Averin <vvs@virtuozzo.com>
Message-ID: <fd8a26fa-02a0-23f6-80a7-f3c83552c5fc@virtuozzo.com>
Date: Thu, 6 Feb 2020 09:11:13 +0300
MIME-Version: 1.0
In-Reply-To: <1b957299-9c5d-9423-3982-10da697b3fb1@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On 2/5/20 10:55 PM, Christian Borntraeger wrote:
> I only got your cover letter, but not the patch itself. Can you resend?

Patch itself had another subject:
"[PATCH 1/1] cio_ignore_proc_seq_next should increase position index"
https://www.spinics.net/lists/linux-s390/msg30430.html

It was reviewed by Cornelia Huck
https://www.spinics.net/lists/linux-s390/msg30433.html

> On 24.01.20 06:48, Vasily Averin wrote:
>> In Aug 2018 NeilBrown noticed 
>> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
>> "Some ->next functions do not increment *pos when they return NULL...
>> Note that such ->next functions are buggy and should be fixed. 
>> A simple demonstration is
>>    
>> dd if=/proc/swaps bs=1000 skip=1
>>     
>> Choose any block size larger than the size of /proc/swaps.  This will
>> always show the whole last line of /proc/swaps"
>>
>> Described problem is still actual. If you make lseek into middle of last output line 
>> following read will output end of last line and whole last line once again.
>>
>> $ dd if=/proc/swaps bs=1  # usual output
>> Filename				Type		Size	Used	Priority
>> /dev/dm-0                               partition	4194812	97536	-2
>> 104+0 records in
>> 104+0 records out
>> 104 bytes copied
>>
>> $ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
>> dd: /proc/swaps: cannot skip to specified offset
>> v/dm-0                               partition	4194812	97536	-2
>> /dev/dm-0                               partition	4194812	97536	-2 
>> 3+1 records in
>> 3+1 records out
>> 131 bytes copied
>>
>> There are lot of other affected files, I've found 30+ including
>> /proc/net/ip_tables_matches and /proc/sysvipc/*
>>
>> Following patch fixes s390-related file
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>>
>> Vasily Averin (1):
>>   cio_ignore_proc_seq_next should increase position index
>>
>>  drivers/s390/cio/blacklist.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
> 

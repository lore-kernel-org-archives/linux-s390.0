Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727085AbgBETzc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 14:55:32 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015JrtJZ017577
        for <linux-s390@vger.kernel.org>; Wed, 5 Feb 2020 14:55:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xym4n1qy5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 05 Feb 2020 14:55:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 5 Feb 2020 19:55:29 -0000
Subject: Re: [PATCH 0/1] s390: seq_file .next functions should increase
 position index
References: <8b5e38e4-ca07-b3c7-bdb7-4f4c3ad94233@virtuozzo.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Feb 2020 20:55:25 +0100
MIME-Version: 1.0
In-Reply-To: <8b5e38e4-ca07-b3c7-bdb7-4f4c3ad94233@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1b957299-9c5d-9423-3982-10da697b3fb1@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

I only got your cover letter, but not the patch itself. Can you resend?


On 24.01.20 06:48, Vasily Averin wrote:
> In Aug 2018 NeilBrown noticed 
> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> "Some ->next functions do not increment *pos when they return NULL...
> Note that such ->next functions are buggy and should be fixed. 
> A simple demonstration is
>    
> dd if=/proc/swaps bs=1000 skip=1
>     
> Choose any block size larger than the size of /proc/swaps.  This will
> always show the whole last line of /proc/swaps"
> 
> Described problem is still actual. If you make lseek into middle of last output line 
> following read will output end of last line and whole last line once again.
> 
> $ dd if=/proc/swaps bs=1  # usual output
> Filename				Type		Size	Used	Priority
> /dev/dm-0                               partition	4194812	97536	-2
> 104+0 records in
> 104+0 records out
> 104 bytes copied
> 
> $ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
> dd: /proc/swaps: cannot skip to specified offset
> v/dm-0                               partition	4194812	97536	-2
> /dev/dm-0                               partition	4194812	97536	-2 
> 3+1 records in
> 3+1 records out
> 131 bytes copied
> 
> There are lot of other affected files, I've found 30+ including
> /proc/net/ip_tables_matches and /proc/sysvipc/*
> 
> Following patch fixes s390-related file
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> 
> Vasily Averin (1):
>   cio_ignore_proc_seq_next should increase position index
> 
>  drivers/s390/cio/blacklist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

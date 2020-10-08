Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgJHIee (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 04:34:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0988WJ36132995
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 04:34:33 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341y3rrf1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 04:34:33 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0988Wp4s028058
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 08:34:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 33xgjh540a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 08:34:31 +0000
Date: Thu, 8 Oct 2020 10:34:26 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [s390:features 73/81] drivers/s390/crypto/ap_queue.c:201:18:
 warning: format specifies type 'unsigned char' but the argument has type
 'int'
Message-ID: <your-ad-here.call-01602146066-ext-5611@work.hours>
References: <202010080727.HGqasHVn-lkp@intel.com>
 <60ba86ba-8912-1c67-8390-10ebcdee2f19@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60ba86ba-8912-1c67-8390-10ebcdee2f19@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>

On Thu, Oct 08, 2020 at 09:00:00AM +0200, Harald Freudenberger wrote:
> 
> On 08.10.20 01:41, kernel test robot wrote:
> > 2ea2a6099ae3d1708f90f43c81a98cba3d4bb74c [73/81] s390/ap: add error response code field for ap queue devices
> 
> Fixed ... but why do these warnings not appear with normal build or with C=1 build ?
> 
> Maybe there is some pragma needed somewhere at where the debug feature printfs expand to ?
> 
> drivers/s390/crypto/ap_debug.h:26:47: note: expanded from macro 'AP_DBF_WARN'
>            debug_sprintf_event(ap_dbf_info, DBF_WARN, ##__VA_ARGS__)

It seems to be the same for printk as well.

Variable function arguments which are passed via ... and of smaller
sizes then int are promoted to ints. It's called "default argument
promotion". So, its not like your code would crash or print garbage
if you use "%hhu" format and pass int or use "%d" and pass unsigned
char. It looks like gcc simply does not complain about such things,
while clang does.

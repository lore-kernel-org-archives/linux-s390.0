Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29796 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgJHHAF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 03:00:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0986WS4n150271
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 03:00:04 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341wk3gp8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 03:00:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0986sArZ030161
        for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2020 07:00:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 33xgx82mmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2020 07:00:01 +0000
Subject: Re: [s390:features 73/81] drivers/s390/crypto/ap_queue.c:201:18:
 warning: format specifies type 'unsigned char' but the argument has type
 'int'
References: <202010080727.HGqasHVn-lkp@intel.com>
From: Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <60ba86ba-8912-1c67-8390-10ebcdee2f19@linux.ibm.com>
Date: Thu, 8 Oct 2020 09:00:00 +0200
MIME-Version: 1.0
In-Reply-To: <202010080727.HGqasHVn-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>


On 08.10.20 01:41, kernel test robot wrote:
> 2ea2a6099ae3d1708f90f43c81a98cba3d4bb74c [73/81] s390/ap: add error response code field for ap queue devices

Fixed ... but why do these warnings not appear with normal build or with C=1 build ?

Maybe there is some pragma needed somewhere at where the debug feature printfs expand to ?

drivers/s390/crypto/ap_debug.h:26:47: note: expanded from macro 'AP_DBF_WARN'
           debug_sprintf_event(ap_dbf_info, DBF_WARN, ##__VA_ARGS__)

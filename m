Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbfJaJ4u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 05:56:50 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V9nxRf039100
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 05:56:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vyvp0hqt9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 05:56:48 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 31 Oct 2019 09:56:47 -0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] scripts/gdb: fix debugging modules compiled with hot/cold
 partitioning
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <130e31f0-ce38-77cb-58a9-cedf3b0f8113@siemens.com>
Date: Thu, 31 Oct 2019 10:56:42 +0100
Content-Transfer-Encoding: 7bit
References: <20191028152734.13065-1-iii@linux.ibm.com>
 <130e31f0-ce38-77cb-58a9-cedf3b0f8113@siemens.com>
Message-Id: <565ED332-3D0E-4741-BB82-3E82371C7054@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

> Am 30.10.2019 um 19:29 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
> On 28.10.19 16:27, Ilya Leoshkevich wrote:
>> gcc's -freorder-blocks-and-partition option makes it group frequently
>> and infrequently used code in .text.hot and .text.unlikely sections
>> respectively. At least when building modules on s390, this option is
>> used by default.
>> 
>> gdb assumes that all code is located in .text section, and that .text
>> section is located at module load address. With such modules this is no
>> longer the case: there is code in .text.hot and .text.unlikely, and
>> either of them might precede .text.
>> 
>> Fix by explicitly telling gdb the addresses of code sections.
>> 
>> It might be tempting to do this for all sections, not only the ones in
>> the white list. Unfortunately, gdb appears to have an issue, when telling
>> it about e.g. loadable .note.gnu.build-id section causes it to think that
>> non-loadable .note.Linux section is loaded at address 0, which in turn
>> causes NULL pointers to be resolved to bogus symbols. So keep using the
>> white list approach for the time being.
> 
> Did you report this to gdb?

Yes: https://sourceware.org/bugzilla/show_bug.cgi?id=25152

Best regards,
Ilya

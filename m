Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B248C433B4
	for <linux-s390@archiver.kernel.org>; Fri, 14 May 2021 13:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E157A61406
	for <linux-s390@archiver.kernel.org>; Fri, 14 May 2021 13:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhENNNz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 May 2021 09:13:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229469AbhENNNz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 May 2021 09:13:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ED3KiF078671
        for <linux-s390@vger.kernel.org>; Fri, 14 May 2021 09:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=DKyxiXsUL+WhDZfY8skG5Q5bqnPcJQ8LxNyfrRWYAKs=;
 b=X6pw7SdJM6I9zWAu1VFriu0He5DyLAuBMmSkQ7wUOa+u8xwqg23YjxEFXArb5/zVQvji
 HDlaDsjs4cdApRFs6mFsHQrM/4ztUgZh53JNL+0uCafjvfPykdP4+OuTcbvOs/qXX0AB
 0Qbf79/hhbf2vzJa4WA3o6FTVNvR6q073k7/5cNdw7TookTwYAmSCl2gySga7oeCIQp3
 KiFEMb8ZeXLD9amMI9OXk8yWvHyDnTSQbFo1SefJH2tqUpDKwxAHGzAuNMnONMFdied4
 6UoPMtbhOrfzYz2ddQcOwHmcaZOFGmto4B7nOyVVy8AzwXaND4VofR8BGhDmlJztmNzQ eg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38hs3t15h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 May 2021 09:12:43 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14EDCc7q032119
        for <linux-s390@vger.kernel.org>; Fri, 14 May 2021 13:12:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38hc6cr9sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 May 2021 13:12:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14EDCc6441746850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:12:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD8E352052;
        Fri, 14 May 2021 13:12:38 +0000 (GMT)
Received: from thinkpad (unknown [9.171.95.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 6FBB85204F;
        Fri, 14 May 2021 13:12:38 +0000 (GMT)
Date:   Fri, 14 May 2021 15:12:37 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: s390 and crashk_res
Message-ID: <20210514151237.3639a67a@thinkpad>
In-Reply-To: <YJk8mrW7DdwwhLuE@linux.ibm.com>
References: <YJk8mrW7DdwwhLuE@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: utSzGjOb7nQpXoWfSwZNx3CBElRs6IaD
X-Proofpoint-GUID: utSzGjOb7nQpXoWfSwZNx3CBElRs6IaD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 10 May 2021 17:00:58 +0300
Mike Rapoport <rppt@linux.ibm.com> wrote:

> Hello,
> 
> I'm trying to consolidate setup of iomem_resource as it is very similar
> across several architectures.  
> 
> Among the differences I've encountered is that s390 keeps crashk_resource
> is not a child of "System RAM" and commit 4e042af463f8 ("s390/kexec: fix
> crash on resize of reserved memory") added a comment that explicitly says
> that "... crash kernel resource should not be part of the System RAM
> resource".
> 
> I could not find what is the reason for this neither in the kernel nor in
> kexec sources.
> 
> Any help will be greatly appreciated!
> 

Hello Mike,

Heiko is out of the office for a couple of weeks, but I think chances
are good that this is just some historic or cosmetic artifact.

We apparently wanted to make extra sure that the crashkernel memory
is as invisible to the kernel as possible, e.g. by not even having
in it in the kernel 1:1 mapping and also w/o struct pages. This was
changed by Heikos patch, as it did not work well with the crashkernel
resizing. The patch did not change the "System RAM" hierarchy, IIUC,
it just added the comment. I assume that both the 1:1 mapping and also
the "System RAM" exclusion were just some overly cautious measures,
just because it was possible.

Since commit 1a085d0727af ("kexec: Set IORESOURCE_SYSTEM_RAM for System
RAM") and bd7e6cb30ced ("resource: Change walk_system_ram() to use System
RAM type"), it should actually not really matter which hierarchy we use
for /proc/iomem, because crashk_res will be flagged as System RAM anyway,
and thus also be visible for any System RAM resource walkers, IIUC.

Those commits went upstream just a bit before Heikos commit, and it might
just not have been noticed (until now) that we do not really hide the
crashk_res from System RAM anymore. I also see no technical impact, other
than cosmetic reasons, i.e. it will not show up as child in /proc/iomem,
but for all other purposes it would still be treated as System RAM, at
least after the two commits mentioned above.

So I would assume that the comment is just misleading, but I cannot
really say for sure. Maybe Heiko can add some more insight when he
returns.

Regards,
Gerald

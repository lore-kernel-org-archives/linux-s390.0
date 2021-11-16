Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A7AC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A8661A38
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 11:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhKPLUn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:20:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234757AbhKPLUl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Nov 2021 06:20:41 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGAmB8H031366;
        Tue, 16 Nov 2021 11:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=02X/oSHsvr/A1veMYZdpbFGyFw+42k3TQtE+KfT8srQ=;
 b=CWAnRpVW2VHt4GCxOJKitKbhC3fCIc7egEW9YqvCKH/YUfJQc1rgL1Hq1j4xnhnc9h2w
 zQ6L6lpEQ3QVXdAzZVbn4lXimMvfopFjDqnN8zjkjNorNT9wnEQQ85t4LkhTfpAxHQYj
 /prn4FkRiVJsTprtSseu+Ssg2nxtBsFnkuPcolmCts8fgauDIVZYxo29131Jza0hcZVY
 /HqfOvxcBqNTBy2u9S+DMkwTMlLnBXEwqxYOGjjfryNVEOsS8/uS9GElJPVxHKGO6JID
 AB2jfuc7sQHrp/clTg0e/KzeQ+vqM7MERQEDYApUCkySaiClGRFrvv00NjzOmnckKRhM 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccb6wrma2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 11:17:42 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AGAv7KS030218;
        Tue, 16 Nov 2021 11:17:41 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ccb6wrm9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 11:17:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AGB8QHQ032497;
        Tue, 16 Nov 2021 11:17:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3ca509whvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 11:17:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AGBAfmb60162314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 11:10:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC2814204D;
        Tue, 16 Nov 2021 11:17:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9953142049;
        Tue, 16 Nov 2021 11:17:36 +0000 (GMT)
Received: from osiris (unknown [9.145.93.200])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Nov 2021 11:17:36 +0000 (GMT)
Date:   Tue, 16 Nov 2021 12:17:35 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, prudo@redhat.com
Subject: Re: [PATCH v2 RESEND 2/2] s390/kexec: fix memory leak of ipl report
 buffer
Message-ID: <YZOTT2v+V14Nk7IB@osiris>
References: <20211116032557.14075-1-bhe@redhat.com>
 <20211116032557.14075-2-bhe@redhat.com>
 <20211116033101.GD21646@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116033101.GD21646@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P9vobwcliHdGJL_HL91TUPWidIE5UOWC
X-Proofpoint-ORIG-GUID: F6m_Izc6A-n0GcWELFVSyrlutw1hu0jZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_01,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160056
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 16, 2021 at 11:31:01AM +0800, Baoquan He wrote:
> unreferenced object 0x38000195000 (size 4096):
>   comm "kexec", pid 8548, jiffies 4294953647 (age 32443.270s)
>   hex dump (first 32 bytes):
>     00 00 00 c8 20 00 00 00 00 00 00 c0 02 80 00 00  .... ...........
>     40 40 40 40 40 40 40 40 00 00 00 00 00 00 00 00  @@@@@@@@........
>   backtrace:
>     [<0000000011a2f199>] __vmalloc_node_range+0xc0/0x140
>     [<0000000081fa2752>] vzalloc+0x5a/0x70
>     [<0000000063a4c92d>] ipl_report_finish+0x2c/0x180
>     [<00000000553304da>] kexec_file_add_ipl_report+0xf4/0x150
>     [<00000000862d033f>] kexec_file_add_components+0x124/0x160
>     [<000000000d2717bb>] arch_kexec_kernel_image_load+0x62/0x90
>     [<000000002e0373b6>] kimage_file_alloc_init+0x1aa/0x2e0
>     [<0000000060f2d14f>] __do_sys_kexec_file_load+0x17c/0x2c0
>     [<000000008c86fe5a>] __s390x_sys_kexec_file_load+0x40/0x50
>     [<000000001fdb9dac>] __do_syscall+0x1bc/0x1f0
>     [<000000003ee4258d>] system_call+0x78/0xa0
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to next kernel")
> ---
> RESEND:
>   Fix the incorrect subject.
> 
>  arch/s390/include/asm/kexec.h         | 7 +++++++
>  arch/s390/kernel/machine_kexec_file.c | 9 +++++++++
>  2 files changed, 16 insertions(+)

Applied, thanks!

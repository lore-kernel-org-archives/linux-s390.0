Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C20EC4338F
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846C160F9C
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 15:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhHCPkn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:40:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236749AbhHCPkl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 11:40:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173FYRAx171233;
        Tue, 3 Aug 2021 11:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Pqxnn6NzQVQnAE+ihFmtL6VEhFisVsHSlUk9Jr3ZR/c=;
 b=RgVM1BU/IXNGrg2F4W0nwEy18nlL9uyU//uZVEBSGdWzt2+B46Mqu2Dn5YqGUdWYpi2h
 ThcdDpUs+LHrWcL/dJSBsO5elWb/cUNq/qOfzjxDt/IFE2dCaX3FhaYRM5JrSbyiXN/6
 h51tKwBykenJeGfP2i/9WZH1ayHzA7//yBEICttFnlbSrwLNEKOHpW3Y2lIhXgJMv4Pi
 wIYp6XqVCz3r5Y/w6/sv5UOqV7Jvek180s20cN4WEObNIBCLnQmibXCOfUc/fD9rr0HV
 HOeXjaLW+Rh9vBzF0yu2nEA3j8Na3vrTOnJUQ88bP3lietG8Cf5R4jZO3XFHf6iiMIVQ Yw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a76d74hm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 11:40:12 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173FWfj1004372;
        Tue, 3 Aug 2021 15:40:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3a4x58pk01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 15:40:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173Fe75055902566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 15:40:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 712ADA407D;
        Tue,  3 Aug 2021 15:40:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24E1CA40A6;
        Tue,  3 Aug 2021 15:40:05 +0000 (GMT)
Received: from osiris (unknown [9.145.48.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Aug 2021 15:40:05 +0000 (GMT)
Date:   Tue, 3 Aug 2021 17:40:03 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 04/38] s390: Replace deprecated CPU-hotplug functions.
Message-ID: <YQljUzNyP81s7VtL@osiris>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-5-bigeasy@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gTZa5OiJLyzvwhI2FMIcyQefyD0sOZi5
X-Proofpoint-GUID: gTZa5OiJLyzvwhI2FMIcyQefyD0sOZi5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_04:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=922 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Aug 03, 2021 at 04:15:47PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: linux-s390@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/s390/hypfs/hypfs_diag0c.c  | 10 +++++-----
>  arch/s390/kernel/diag.c         |  4 ++--
>  arch/s390/kernel/irq.c          |  4 ++--
>  arch/s390/kernel/perf_cpum_cf.c |  4 ++--
>  arch/s390/kernel/processor.c    |  4 ++--
>  arch/s390/kernel/smp.c          |  8 ++++----
>  arch/s390/kernel/topology.c     |  4 ++--
>  arch/s390/mm/maccess.c          |  4 ++--
>  8 files changed, 21 insertions(+), 21 deletions(-)

Applied, thanks!

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B98C433ED
	for <linux-s390@archiver.kernel.org>; Fri, 30 Apr 2021 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D3A6145D
	for <linux-s390@archiver.kernel.org>; Fri, 30 Apr 2021 15:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhD3Pn5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:43:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63504 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229877AbhD3Pn5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Apr 2021 11:43:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UFYBCW047826;
        Fri, 30 Apr 2021 11:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+5YW0v6FANXvcr19yN+yeH/I2YPVJEMgsaNEPKYY/Nk=;
 b=tpshpd2kU6X3kLa3yYIvIvrKP01/LxRfPzM299FWlugDNd52f4xdlB9NVmaIWKHN8LVL
 Jdia9QSJHccnwIjXwXWtwBZK2F05F+wI206irdALQN1JCMhl2AKXVbjLDGTTRh8HTr3+
 VJoNHSGp20rH2MosLA4eEyRAhx5jY6YD3WQOy1H4t27eKTThuTnBQpfpbXvqSvpU9e2Y
 cP6mgaEUcccatvvRnI0CD2gymQ52VHWDOLOPhRm1JeXYlMbx+6Gk6XGWT53L5S4p6S1U
 oIuBZmNd1/t4beRLN6phtUR57mG1wAai9CMOYnNP9rAShC0zjKSIK/vkqJWaqqAuyqiw Ag== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388me1rw99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 11:43:05 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UFWN6O026145;
        Fri, 30 Apr 2021 15:43:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 384ay81uhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 15:43:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UFga8X31260972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 15:42:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B23154C040;
        Fri, 30 Apr 2021 15:43:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FCD74C04A;
        Fri, 30 Apr 2021 15:43:00 +0000 (GMT)
Received: from osiris.fritz.box (unknown [9.171.59.76])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 30 Apr 2021 15:43:00 +0000 (GMT)
Date:   Fri, 30 Apr 2021 17:42:58 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: add support for syscall stack randomization
Message-ID: <YIwlgusydxiQRyPl@osiris.fritz.box>
References: <20210429091451.1062594-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429091451.1062594-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LmmIKjm5C1VxLgOStp_ABKt5BYY-jYgD
X-Proofpoint-GUID: LmmIKjm5C1VxLgOStp_ABKt5BYY-jYgD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_10:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300105
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Apr 29, 2021 at 11:14:51AM +0200, Sven Schnelle wrote:
> This adds support for adding a random offset to the stack while handling
> syscalls. The patch uses get_tod_clock_fast() as this is considered good
> enough and has much less performance penalty compared to using
> get_random_int(). The patch also adds randomization in pgm_check_handler()
> as the sigreturn/rt_sigreturn system calls might be called from there.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/Kconfig                    |  1 +
>  arch/s390/include/asm/entry-common.h | 10 ++++++++++
>  arch/s390/kernel/syscall.c           |  1 +
>  arch/s390/kernel/traps.c             |  2 ++
>  4 files changed, 14 insertions(+)

Applied, thanks!

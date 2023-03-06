Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95CC61DA4
	for <linux-s390@archiver.kernel.org>; Mon,  6 Mar 2023 14:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCFOCL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCFOCK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Mar 2023 09:02:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1865BAB
        for <linux-s390@vger.kernel.org>; Mon,  6 Mar 2023 06:02:09 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326DB9DV001434;
        Mon, 6 Mar 2023 14:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=L8SoYcPzAxM9HSaVKrdYv6oYiE+npdMKvWZD7Km3Dns=;
 b=VaqlUKbbT4JfXol9Qr0kqJ8XAwwm38K9sjStuTJvpwNHfqX1uyngiYTWnBNiQje3PI8l
 yZI95zHFTQzWCBPYyC5mMudI36bjMLTC0eaNavatBt81KXutHDDxrRHI6rcuHs0s8dSG
 o/y8z/fT01eXWog05EDu0+hAw1GY+ZjuxnapQjt2iChMn+DC/9WKVQ55k7Xe7K0IBawt
 CScD3o4RqPiz1W6eIKDNEgZedsY8/vw/7vYJR1x8bwDqsV7WPw8Z5NL7fcYQ+sMyWnAk
 wa+1pBYsWy4NvOzBaiczV3Za80XQ1fnr6gIKLgok0usdJyl7uV0qDMT8lsk1BcMtVpqz Pw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p507nw77d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:02:08 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3265OatI001841;
        Mon, 6 Mar 2023 14:02:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3p4192a79x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:02:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326E24eA13500774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 14:02:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B7E220065;
        Mon,  6 Mar 2023 14:02:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2880820063;
        Mon,  6 Mar 2023 14:02:04 +0000 (GMT)
Received: from osiris (unknown [9.179.5.86])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Mar 2023 14:02:04 +0000 (GMT)
Date:   Mon, 6 Mar 2023 15:02:02 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: trim ancient junk from copy_thread()
Message-ID: <ZAXyWqNMlftSJfPh@osiris>
References: <ZAU6BYFisE8evmYf@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAU6BYFisE8evmYf@ZenIV>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DebOQZoRerMjYTT80O0btyUn97lS-bQA
X-Proofpoint-ORIG-GUID: DebOQZoRerMjYTT80O0btyUn97lS-bQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=900 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Mar 06, 2023 at 12:55:33AM +0000, Al Viro wrote:
> Setting and ->psw.addr in childregs of kernel thread is a rudiment of
> the old kernel_thread()/kernel_execve() implementation.  Mainline hadn't
> been using them since 2012.
> 
> And clarify the assigments to frame->sf.gprs - the array stores grp6..gpr15
> values to be set by __switch_to(), so frame->sf.gprs[5] actually affects
> grp11, etc.  Better spell that as frame->sf.gprs[11 - 6]...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index 67df64ef4839..87ca3a727604 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c

Applied, thanks!

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D1C001E0
	for <linux-s390@archiver.kernel.org>; Sat, 29 Jul 2023 13:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjG2NtX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 29 Jul 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjG2NtW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 29 Jul 2023 09:49:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5D3C34;
        Sat, 29 Jul 2023 06:48:52 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36TDbIiM031112;
        Sat, 29 Jul 2023 13:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=s3Dpt9/Akir8D+wN5eg5h6OEnmWtXo2JnD1s7kZNIDo=;
 b=kfia2HBuXRTqNAeCbXqTPzwMDNPLChvsTp/8vNBovFEZYuqVK5wkkPfTIii7ObaqHbOB
 GP0qvSzWuZ4l/Vtb+TUHRRnXly35dYEMDH/ODZh/k/e3HiTLPljsnLD42myxinJlQ1zl
 BqTBB9BkKEkMQDFHPjY+yOkqCAnazvOxINM8T5RP0PPJenIXnzpZxl+fEBhdsYmy4Kd1
 fbe6Oc/tnj1xum3r/gUqXFYxmobWitEoDoxQgRBzVM2abaiJ3DZanVssNlkOATPD/3zF
 oar8YkvpCfR8x7G/+DZ75M7q7b7/eEHd/TTnXc2MNKCd3CV5g8WKFdLnAZM0TLQh2k2b kQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s53jgra16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 13:48:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36TDKceK003714;
        Sat, 29 Jul 2023 13:48:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txkxd15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 13:48:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36TDmWLd18088494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 13:48:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D974A20043;
        Sat, 29 Jul 2023 13:48:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C6C820040;
        Sat, 29 Jul 2023 13:48:32 +0000 (GMT)
Received: from osiris (unknown [9.171.58.8])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Jul 2023 13:48:32 +0000 (GMT)
Date:   Sat, 29 Jul 2023 15:48:31 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-next@vger.kernel.org,
        Anastasia Eskova <anastasia.eskova@ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] s390/certstore: select CRYPTO_LIB_SHA256
Message-ID: <20230729134831.6882-C-hca@linux.ibm.com>
References: <20230728100430.1567328-1-svens@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728100430.1567328-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UeuQTJleGIw3rYxRX31Q9iqglf85hkLg
X-Proofpoint-ORIG-GUID: UeuQTJleGIw3rYxRX31Q9iqglf85hkLg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=910 clxscore=1011 impostorscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307290126
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jul 28, 2023 at 12:04:30PM +0200, Sven Schnelle wrote:
> A build failure was reported when sha256() is not present:
> 
> gcc-13.1.0-nolibc/s390-linux/bin/s390-linux-ld: arch/s390/kernel/cert_store.o: in function `check_certificate_hash':
> arch/s390/kernel/cert_store.c:267: undefined reference to `sha256'
> 
> Therefore make CONFIG_CERT_STORE select CRYPTO_LIB_SHA256.
> 
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/8ecb57fb-4560-bdfc-9e55-63e3b0937132@infradead.org/
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!

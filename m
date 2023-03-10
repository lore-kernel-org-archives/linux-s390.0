Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C72C6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCJNFX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCJNFW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:05:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024DDF731
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:05:20 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AC1wdA023629
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : cc :
 from : subject : to : message-id : date; s=pp1;
 bh=cEL+hammybmy8dlwpCfTFGnCNB5ILtmgHx4mnaFStWc=;
 b=o3CVL7ix7Czxfn5XRBBzaVfx2lkgW8317N8MtFSlJDSIhPhJrsYTNdgf5YwEGj1FcnBb
 ctcu9hK2zYJmgnIfwSPdwKs5Ig3mEjkpfjrix1zc7e/Z32jsxpdsiuZsMN7IZLpRWHwS
 leZUNHXyuBEIkKogC78hn+sUQlquyfXtqI4tw+no1eFYSr+BNfc8VTyAep9Ynbv1dl5Z
 ZKwrton6daX2/RbDoWIV9reaXEB6RaL4rbI/RSuF9mD4HxyhqDDoEYKmhE+h1Qe5eDWx
 ccU0tpeK7LbpZ8SfKS/vv0VDFS3RDszlXfVV94cZej8g80I0gyyICFsy3PldoswUmNOc rA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p846v9g9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:05:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A7Evrf020006
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:05:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p6ftvkvy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:05:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AD5ECb28639976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:05:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 398A120049;
        Fri, 10 Mar 2023 13:05:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BEBA20040;
        Fri, 10 Mar 2023 13:05:14 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.19.247])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:05:14 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230310122204.1898-1-nrb@linux.ibm.com> <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com> <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
From:   Nico Boehr <nrb@linux.ibm.com>
Subject: Re: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Message-ID: <167845351380.47430.11455902036478848776@t14-nrb>
User-Agent: alot/0.8.1
Date:   Fri, 10 Mar 2023 14:05:13 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UZdNYKwobwcCNpA9TL1fVc6d369Bi7Qr
X-Proofpoint-GUID: UZdNYKwobwcCNpA9TL1fVc6d369Bi7Qr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=392 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303100104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Quoting Alexander Gordeev (2023-03-10 13:42:47)
> On Fri, Mar 10, 2023 at 01:34:27PM +0100, Alexander Gordeev wrote:
> > > Note that several callers pass NULL as addr, this is fine since
> > > virt_to_phys(0) =3D=3D 0.
>=20
> Missed that.
>=20
> Are you sure? Quickly checked ppc64, x86 and arm64 - they do not=20
> seem adhere virt_to_phys(0) =3D=3D 0, nor the VR kernel (so far).

I think we do, but you are right - it might change in the future, so it's b=
etter to be on the safe side. Fixed in v2, thanks.

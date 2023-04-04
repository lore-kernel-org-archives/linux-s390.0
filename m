Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3674C6FD1D
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 07:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjDDHGS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 03:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjDDHGR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 03:06:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834C132
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 00:06:16 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3346BspY028736
        for <linux-s390@vger.kernel.org>; Tue, 4 Apr 2023 07:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : cc :
 from : subject : to : message-id : date; s=pp1;
 bh=ZW+VqI4Wh2OKgyhNE3rhR9qO1NllnbimMIUp4vqMr0M=;
 b=tdTvVFkgIqj3EOvbsIbCSmiq/xyjNpEeogiQw2THckMFAIUx811KgW1bLDTFb9Y/KogM
 C684OW61krmzb+b2dasFNFdrlTxtmpYCg2hXEvx29E7YMIMWAhP+Tc5M+V7l+/qjzSMk
 hGe38b80ugL8ilC5Z3JwVSPgfqWcY8hd8Jzb49v5+VX9Ss4NlzGYznaRBOCCnb9uJwDm
 psL7qLbP+THc6KHLmdQHUxSK1/TeHfhkckjtDIlZT654TUkSkaTgAwc/wJcvtouaiNnm
 DzELCi0Ik1SrmvSjyhcL8jB/aEYV7QzpkEDd31C/hGCnVfc5LfRR4M84K7AcnSD/Xczi qQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pr31v0r6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 07:06:15 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3344Nuxb013730
        for <linux-s390@vger.kernel.org>; Tue, 4 Apr 2023 07:06:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ppc86sque-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 07:06:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 334769bd45023718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Apr 2023 07:06:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C49FC20043;
        Tue,  4 Apr 2023 07:06:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A326320040;
        Tue,  4 Apr 2023 07:06:09 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.55.238])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Apr 2023 07:06:09 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZCvGEEyQZ7JTsEcc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230310133411.139275-1-nrb@linux.ibm.com> <20230310133411.139275-2-nrb@linux.ibm.com> <ZCaCRTNEJKDMfhQo@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com> <168024697476.295696.16876742423274337392@t14-nrb> <ZCvGEEyQZ7JTsEcc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
From:   Nico Boehr <nrb@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] s390: ipl: fix physical-virtual confusion for diag308
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Message-ID: <168059196934.9920.6083840912989785654@t14-nrb>
User-Agent: alot/0.8.1
Date:   Tue, 04 Apr 2023 09:06:09 +0200
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: up4OgHtSPKJ5Q6LIUnBS-tDBXSfvrVbl
X-Proofpoint-ORIG-GUID: up4OgHtSPKJ5Q6LIUnBS-tDBXSfvrVbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=476 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Quoting Alexander Gordeev (2023-04-04 08:39:12)
> On Fri, Mar 31, 2023 at 09:16:14AM +0200, Nico Boehr wrote:
> > > Anything prevents this one from pushing?
> > No, can be pushed.
>=20
> Could you push it then, please?

Done.

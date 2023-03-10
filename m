Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FACC6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjCJNcC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJNcA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:32:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BE102B68
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:31:42 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACCDGE015378
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NNEVMaa5ogsgsl+XOG5ln7YHvKIXA0INt9M0SIRIuP4=;
 b=FGZHQeDSqkHJnkF0M2rOSx7bWZWeKBejdheM4MxDxU7uT1VGp6bZdUuhP1k4s2/jlX8r
 /gK1L4Mi98EFe9oFkek5Wc8iKOWX3cvU6Wll/CL+YQtAKb0rbRCg7Dd3iuZPZYdURu6B
 hb5YszOrX60StDf/8W+MWxh+WtNXFhePF1c33GcKrEOOUZvyxk3HMWnNcB49Ff6krXnZ
 eAxN31JnwdMKHs3kb75HGBb0/oPTS3Hv/2F1AnJFxHZ6Y4kUH1cIAoHgxY33YjbxeRNo
 WQErY/OSrAb3ZIGm3z4MwXY76NTtJgv2YfgPv+1At3bPepJ7TFPOTi4EU0hDEUGlk+FD EA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84be1vsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:31:41 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8jVY2003010
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:31:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3p6g0jjwv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:31:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADVaEU45023708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:31:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6A7A20043;
        Fri, 10 Mar 2023 13:31:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04FD320040;
        Fri, 10 Mar 2023 13:31:35 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.36.141])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 13:31:34 +0000 (GMT)
Date:   Fri, 10 Mar 2023 14:31:33 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Nico Boehr <nrb@linux.ibm.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
Message-ID: <ZAsxNRTQzjfS3jZH@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20230310122204.1898-1-nrb@linux.ibm.com>
 <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com>
 <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <64918275-3f63-68c5-1c82-ff2b60114662@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64918275-3f63-68c5-1c82-ff2b60114662@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _vhl13t1KxwA-2Sysg4iC462dRwbK-92
X-Proofpoint-ORIG-GUID: _vhl13t1KxwA-2Sysg4iC462dRwbK-92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=677
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 10, 2023 at 02:20:32PM +0100, Christian Borntraeger wrote:
> > Are you sure? Quickly checked ppc64, x86 and arm64 - they do not
> > seem adhere virt_to_phys(0) == 0, nor the VR kernel (so far).
> 
> Isnt that the prefix page? I think we did say that the prefix page must be 0 in virt and phys otherwise we will have performance issues due to cache synonyms.

As far as I am concerned we should keep virt_to_phys() semantics in
sync with other archs and one should not rely on s390 implementation-
specifics. Please, see also my other reply to Nico in v2.

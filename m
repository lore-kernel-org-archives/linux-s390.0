Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B049C6FD18
	for <linux-s390@archiver.kernel.org>; Fri, 31 Mar 2023 06:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCaGsu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 31 Mar 2023 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCaGsr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Mar 2023 02:48:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598491
        for <linux-s390@vger.kernel.org>; Thu, 30 Mar 2023 23:48:47 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V6Eica000905
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 06:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XCNT/8QnAFmbiKYb8Vh7pys14s5W0be+vNAQJL2MWHw=;
 b=QxSyRCijARj7yy+fNSb9ijduKInAOzksNkvUIMR3tHM4s9iWxtwreZHhVd/0CQB3em7b
 /TnCipGpvStQ12wtII3Mdgo4+OiXL/r600ENLl169CloCDUatv+ebQ8Og2U8KX18/h2h
 N+fRL2DTpQwPAEhYC2XSuppTSUBT1+U5ODOJACuDcfdE2qflgKQiPCA07MgmKy5q1JAk
 MLpqWBz8z4Jr9au0sC9e4FfbuFrbK9uVPKGdE0FUWWqNBMW6DqKJIpIAl3VNVy3MLCFG
 CQ33eP6oz7Q+xjBcQ+6Nlo4pPoj7YNVb1upe6HeTc36wvnI0kmOGM6D4dOo81es1qILu Hw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pnkvryua7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 06:48:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32ULEGs9019506
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 06:48:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6phm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 06:48:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32V6meSX36962752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Mar 2023 06:48:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A066220043;
        Fri, 31 Mar 2023 06:48:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D858420040;
        Fri, 31 Mar 2023 06:48:39 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.10.226])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 31 Mar 2023 06:48:39 +0000 (GMT)
Date:   Fri, 31 Mar 2023 08:48:37 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: ipl: fix physical-virtual confusion for
 diag308
Message-ID: <ZCaCRTNEJKDMfhQo@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230310133411.139275-1-nrb@linux.ibm.com>
 <20230310133411.139275-2-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310133411.139275-2-nrb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mMLgSHb3f7ZPfWx4Q70H8a1hE1HYGgC3
X-Proofpoint-ORIG-GUID: mMLgSHb3f7ZPfWx4Q70H8a1hE1HYGgC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 mlxlogscore=481 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303310053
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Nico,

Anything prevents this one from pushing?

Thanks!

Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBD6C6FD1D
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 06:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjDDGj1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 02:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDDGjZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 02:39:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D851BE1
        for <linux-s390@vger.kernel.org>; Mon,  3 Apr 2023 23:39:22 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3346aEOJ006001
        for <linux-s390@vger.kernel.org>; Tue, 4 Apr 2023 06:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=g2z0o6A9XIARI6PwBxL7jddQu8xpNWypLqrqGMDXF/0=;
 b=EbAXL/eKN6hqqDdp3D8+/+g24Vt1fBN282T4+I7WLzZ8EweCHuiaVxXvdirpLmvSszXE
 BZBjxmPHf3saUJ93bpVZNzNuFhQJgh01NVo1eS3YJd1Ph55v/GzDXJwjF4DZMw61EKWC
 iKkDeGVoGM/jKjiYdA4e4ndiC94n3rLCQrsNkufQI5PLbe8Dfp+VThN0/hJ9FDTSFz0V
 C5vyUn5sXRq+5mi3bI9q4Z3DSUdjDIWLfj5Nnq769k/QDQyvEDM6oDm6MuXbrBreOXwU
 1ZcEo/CqAr1LtUnCqk70PK/nVc6YV3Oy82UN11kCKJYhu9EX+jM77WICvvN0LPfLTR41 fw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pqygxfgj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 06:39:22 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3342ZYo0019405
        for <linux-s390@vger.kernel.org>; Tue, 4 Apr 2023 06:39:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ppc86sqd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 06:39:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3346dEHT26083912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Apr 2023 06:39:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5600C2004D;
        Tue,  4 Apr 2023 06:39:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A537C20040;
        Tue,  4 Apr 2023 06:39:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.23.84])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Apr 2023 06:39:13 +0000 (GMT)
Date:   Tue, 4 Apr 2023 08:39:12 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Nico Boehr <nrb@linux.ibm.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: ipl: fix physical-virtual confusion for
 diag308
Message-ID: <ZCvGEEyQZ7JTsEcc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230310133411.139275-1-nrb@linux.ibm.com>
 <20230310133411.139275-2-nrb@linux.ibm.com>
 <ZCaCRTNEJKDMfhQo@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <168024697476.295696.16876742423274337392@t14-nrb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168024697476.295696.16876742423274337392@t14-nrb>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LcZs9SRJogitKri-bWESLSQ9KCyIFOe7
X-Proofpoint-GUID: LcZs9SRJogitKri-bWESLSQ9KCyIFOe7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=527
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040060
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 31, 2023 at 09:16:14AM +0200, Nico Boehr wrote:
> > Anything prevents this one from pushing?
> No, can be pushed.

Could you push it then, please?

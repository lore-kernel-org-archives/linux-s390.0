Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D941EC6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCJNhb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCJNha (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:37:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767231111D1
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:37:15 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ABsxR1002764
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4EJzD6FRyjfHEXgGS2aRItmUIiah9YDmCbziBb8UklA=;
 b=lQYnt0ildc8VXkmYT30CiUAaMdAiwVby9w44MCW6KNNhEjhQFH4uq8jp67o4654eW2P4
 e9rhvUmsm+lZay13hjLOMU6NIIDIoKowCZ2zlxgpCQj8SU3i5U72pKFRrMOAe4UyLc8/
 0BQ9+uwaSzwhoPbfwVzTmkNfQwM1zYrgDCQB3/segKyGaoQF71fQC0/e3d/I/p+1NnrB
 Q4DrYW8EPi641I5x3YXfbkJL+lfYM2jdFOQJnRs99hNG6Jc4BWSFhTtFNJfzkqO716nD
 gEBtz5sfyDvuzZyzaAAI0hNIiI+UrA4AU/8jW7vFzvZq/MtSG23iTwN2C2NfuhFGXT/+ fw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p843ktkm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:37:15 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8NXui015878
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:37:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3p6g75awhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:37:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADb9go64422150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:37:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23EFB20040;
        Fri, 10 Mar 2023 13:37:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A499A2004B;
        Fri, 10 Mar 2023 13:37:08 +0000 (GMT)
Received: from [9.171.92.206] (unknown [9.171.92.206])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:37:08 +0000 (GMT)
Message-ID: <409ae5b6-c52e-7e8f-030c-e2bca0a3b2a9@linux.ibm.com>
Date:   Fri, 10 Mar 2023 14:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] s390: ipl: fix physical-virtual confusion for diag308
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Nico Boehr <nrb@linux.ibm.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
        mhartmay@linux.ibm.com
References: <20230310122204.1898-1-nrb@linux.ibm.com>
 <ZAsjzoA07NTYENku@tuxmaker.boeblingen.de.ibm.com>
 <ZAslxw+V0FY9bYLF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <64918275-3f63-68c5-1c82-ff2b60114662@linux.ibm.com>
 <ZAsxNRTQzjfS3jZH@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <ZAsxNRTQzjfS3jZH@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MkoBiLgm88E2SdY1Jk2tBE826tQ7Uc21
X-Proofpoint-ORIG-GUID: MkoBiLgm88E2SdY1Jk2tBE826tQ7Uc21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=753 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 10.03.23 um 14:31 schrieb Alexander Gordeev:
> On Fri, Mar 10, 2023 at 02:20:32PM +0100, Christian Borntraeger wrote:
>>> Are you sure? Quickly checked ppc64, x86 and arm64 - they do not
>>> seem adhere virt_to_phys(0) == 0, nor the VR kernel (so far).
>>
>> Isnt that the prefix page? I think we did say that the prefix page must be 0 in virt and phys otherwise we will have performance issues due to cache synonyms.
> 
> As far as I am concerned we should keep virt_to_phys() semantics in
> sync with other archs and one should not rely on s390 implementation-
> specifics. Please, see also my other reply to Nico in v2.

I agree with that.
I am just saying that we should never have virtual/real for prefix != 0 on current machines.

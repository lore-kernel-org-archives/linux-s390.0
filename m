Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A1C7EE23
	for <linux-s390@archiver.kernel.org>; Mon, 15 May 2023 15:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbjEOP2J (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 15 May 2023 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbjEOP2H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 May 2023 11:28:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11319B1;
        Mon, 15 May 2023 08:28:06 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FFKII1023178;
        Mon, 15 May 2023 15:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Oi7XnXA/+8zSbP8GqBgxZS3Z7rIe3p25MKB4URhZEp0=;
 b=goalteNz3B0aW5iGn/VlxvSylgUdmR69WlkUj9gK98PGMLRNoPvcDSu3ADKpUHh4WCsZ
 +H1hCf0p3V7k87pF1zdT2jogWgzPy2qJqUUIuO5ttyibxRa561VHvT3cimNJCkyQnv22
 3Z8QmHa+sAqMxqyvPCtqg4qGRny+aztEMe1hq7qHexgBycW8sjfII6RQgx1SBImFhLjp
 yretAs9MEMx5mI+yfqb5G+OhyjEZWGr8siO9FQJp9RTYsTeAqNNwBdL16yu8H5Ayt3z/
 6rYHkKTnprvH4Gunvf7+GrOvMhDfEPnieP3Z/zBrEb2CrjCArrCXWMGrImmlyjLYrimY Tg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qkpes2dnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:27:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34ENb3Bd006230;
        Mon, 15 May 2023 15:27:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264s55j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:27:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34FFROZJ10552014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 15:27:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8B8F20043;
        Mon, 15 May 2023 15:27:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71EB320040;
        Mon, 15 May 2023 15:27:24 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 15 May 2023 15:27:24 +0000 (GMT)
Date:   Mon, 15 May 2023 17:27:23 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Jason Herne <jjherne@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2] iommu/s390: Get rid of S390_CCW_IOMMU and
 S390_AP_IOMMU
Message-ID: <ZGJPW5KO+c0HqmcS@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <0-v2-eb322ce2e547+188f-rm_iommu_ccw_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-eb322ce2e547+188f-rm_iommu_ccw_jgg@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JZEpDfyMTfqjFuo1KoSQDnKsjLqciCSF
X-Proofpoint-ORIG-GUID: JZEpDfyMTfqjFuo1KoSQDnKsjLqciCSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=660 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305150124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 01, 2023 at 02:11:28PM -0300, Jason Gunthorpe wrote:
> These don't do anything anymore, the only user of the symbol was
> VFIO_CCW/AP which already "depends on VFIO" and VFIO itself selects
> IOMMU_API.
> 
> When this was added VFIO was wrongly doing "depends on IOMMU_API" which
> required some contortions like this to ensure IOMMU_API was turned on.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/s390/vfio-ap.rst    |  1 -
>  arch/s390/Kconfig                 |  3 +--
>  arch/s390/configs/debug_defconfig |  2 --
>  arch/s390/configs/defconfig       |  2 --
>  drivers/iommu/Kconfig             | 16 ----------------
>  5 files changed, 1 insertion(+), 23 deletions(-)

Applied,
Thanks you!

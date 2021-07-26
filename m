Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44280C4338F
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jul 2021 22:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FDC60F5B
	for <linux-s390@archiver.kernel.org>; Mon, 26 Jul 2021 22:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGZWDO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:03:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26848 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhGZWDO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Jul 2021 18:03:14 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QM8UC3136893;
        Mon, 26 Jul 2021 18:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=16DXP9GnZ2JvM0e4ysTidTzka9jUM7L0eUZ62586l+Q=;
 b=saFQmEHvIiRO07cxpijTmGu6Ea1FBG4J5bc7FMQr229d6faA65D/ovFtMRe74CYKTR2c
 ocCRJTE5D/ZCcMgjAancCtGpwOLcnTV3qsZoeklNqtUtpa+KnuDm7y/M8y1GOzY/UviG
 mlGtOlzIVoffRuoA8vrmmDX0pLPuAh/ii/ASBZN1pu4wOO3edpEBxTv0pIp+ewri+XFK
 A7vxBFnLdr7Yl1SIquRj60hEGyO6A1sarzCp4YhF1Dh8XM027KtebDsPSZSBPge/xgb4
 AFhKufhgv3QtXFqdWI0LtmFbFl/bRnyZImvHMb++CTvOrVbQAKw3tmAJN1fmji8w31LN TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a25k6gp3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 18:43:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16QMZSZg044179;
        Mon, 26 Jul 2021 18:43:39 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a25k6gp2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 18:43:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16QMY5sL020017;
        Mon, 26 Jul 2021 22:43:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3a235xr1dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 22:43:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16QMhXsB29556996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 22:43:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC947A4068;
        Mon, 26 Jul 2021 22:43:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A51CCA4067;
        Mon, 26 Jul 2021 22:43:32 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.33.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 26 Jul 2021 22:43:32 +0000 (GMT)
Date:   Tue, 27 Jul 2021 00:43:29 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210727004329.3bcc7d4f.pasic@linux.ibm.com>
In-Reply-To: <20210726220317.GA1721383@nvidia.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-3-akrowiak@linux.ibm.com>
        <20210721164550.5402fe1c.pasic@linux.ibm.com>
        <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
        <20210723162625.59cead27.pasic@linux.ibm.com>
        <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
        <20210726223628.4d7759bf.pasic@linux.ibm.com>
        <20210726220317.GA1721383@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EkASRpZg-Ob82msNFzZbQf8ROsJ4yYbb
X-Proofpoint-ORIG-GUID: QCzJCtdH7BEfXjqvTAZRe2y9ZH0DDI-j
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_14:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107260127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 26 Jul 2021 19:03:17 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> > You may end up with open and close running interleaved. What I'
> > trying to say is, to my best knowledge, normally there is no
> > you have to close it before you open it again rule for files.  
> 
> This is an existing bug in this driver, I've fixed in the reflck series.
> 
> open_device/close_device will not run concurrently, or out of order,
> afer it is fixed.

Well if that is the case then provided your fix precedes this patch:

Acked-by: Halil Pasic <pasic@linux.ibm.com>

I'm not entirely happy with this. I did not thoroughly investigate the
implications of reversing the locking order of the vfio-ap lock (driver
global) and the kvm lock (guest specific). I will trust Tony and hope
our KVM maintainers will scream if this is bad from interference and
delay perspective.

Regards,
Halil

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C78CC433ED
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F06761165
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 23:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhDZXml (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 19:42:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237728AbhDZXmj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 19:42:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QNWZfq105785;
        Mon, 26 Apr 2021 19:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GrMfCypSxBPUkIs6PWVlXFSkDbp5LxXarQPyF1OCv9E=;
 b=i4DGP7+zUKid3YHpWgRLwDDIllgzQWfN/kRZ/0KBIx7RzcBv5VRHIBiQvAc4qKlaHrUu
 P+7T4JotMTXmXxlBu4XxcjTBOchNrEYTSe8VBVBYzlq4sGCG89IggKVe1RQXPSpDY0ti
 s4s16n0Qhd5m6nwA278kA3D4OOJiqCV1PoYgRNCnUSdW+8c4e3MLhjFJXprMpnOFMMir
 A3Ab1JNYK+e2v4VOb+ka0qOi6KTUzg7XzI1vUSrTZ4BUNA85eqmcSzwFynHQIzfFChqK
 1EOmdlhwDjP1tJIGYVIXI3ATia36PeNg98bvYLr3eh+63HoM54R3Il8qSfCQlNamPqf8 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386533k5nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 19:41:52 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13QNYoAO115926;
        Mon, 26 Apr 2021 19:41:52 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386533k5n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 19:41:51 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QNcq0l002266;
        Mon, 26 Apr 2021 23:41:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 384akh8juv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 23:41:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QNfiHE26018176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 23:41:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B7342045;
        Mon, 26 Apr 2021 23:41:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9745C4203F;
        Mon, 26 Apr 2021 23:41:43 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.4.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 26 Apr 2021 23:41:43 +0000 (GMT)
Date:   Tue, 27 Apr 2021 01:41:41 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210427014141.02c8c82c.pasic@linux.ibm.com>
In-Reply-To: <20210426194859.1665730d.cohuck@redhat.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
        <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
        <20210426194859.1665730d.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sKTSDrbyDlDWwSYIEUMuG-C-jQ_ynaVt
X-Proofpoint-ORIG-GUID: SLdOqBqWi56g8Tk9yhHpp9PXGavfyHQl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_12:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxlogscore=952 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260180
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 26 Apr 2021 19:48:59 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> So my question for the vfio-ap maintainers is: Can we actually end up
> in this case? If yes, is there any way to gracefully shut down the
> device?

@Tony: Can you take this one?

Regards,
Halil

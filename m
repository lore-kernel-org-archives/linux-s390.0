Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E2C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 22:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE476108D
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 22:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhHRWxr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:53:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhHRWxq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 18:53:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IMYfYK077350;
        Wed, 18 Aug 2021 18:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=osAy7ESwkiqn3l7E+004J/iSv+fiZ24QoD3Wg4uPYhM=;
 b=o+HMKdT3wQSGx9ENEON/9FhkXIcKC+JtTs3PLoq5fLVpKOYsajCQSpTzYy5Ugzj0Slyu
 RcWvlllnOydFjc2aEj/dXy+dwqN1qL9lhHVZnxEEZF3Qh2m/EZWQhGibM3eLtdeOy+H9
 l10GsG6tBOZgS9KABD1fPg1+ygskPu472v5VnVB4mT4+JyI0YPhD0P5m4zgrHRqW0fwS
 4u+CoNppeELc9TTMwvTpaAUGymzxcqqZR0HVWNwExQq/saRN28nKx+hAysICl4sD3TNv
 zf6/p0l54DvfzYF2AQ6g75a1ivEBILH9hN3PYNS0nysYgGnBTZcVFGq3Tirm/rVIc1qj PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agfdy6has-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 18:53:09 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17IMZRAj085105;
        Wed, 18 Aug 2021 18:53:08 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agfdy6ha8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 18:53:08 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17IMqDCw006124;
        Wed, 18 Aug 2021 22:53:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ae5f8fbtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 22:53:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17IMr2Zi54198768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 22:53:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A228A4062;
        Wed, 18 Aug 2021 22:53:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E701A4066;
        Wed, 18 Aug 2021 22:53:01 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.56.174])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 18 Aug 2021 22:53:01 +0000 (GMT)
Date:   Thu, 19 Aug 2021 00:52:58 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH 0/2] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210819005258.790163dd.pasic@linux.ibm.com>
In-Reply-To: <4dac22cf-1956-41eb-88da-f16af58530a3@de.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <3f45fe31-6666-ac87-3a98-dd942b5dfb3c@linux.ibm.com>
        <20210802155355.22b98789.pasic@linux.ibm.com>
        <6f37ef28-3cce-2f4f-3173-2c1e916900cc@linux.ibm.com>
        <6d64bd83-1519-6065-a4cd-9356c6be5d1a@de.ibm.com>
        <20210818103908.31eb5848.alex.williamson@redhat.com>
        <4dac22cf-1956-41eb-88da-f16af58530a3@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n2q-DKlkF-jjM-H6WI_JOFS9kIZwB0Bx
X-Proofpoint-ORIG-GUID: mca0-ImpELqLfwFMnfsc1jKc6cayoDDd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_07:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180135
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 18 Aug 2021 18:50:47 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> > that Halil's concern's around open/close races are addressed by Jason's
> > device_open/close series that's already in my next branch and he
> > provided an Ack, but there's still the above question regarding the
> > kvm->lock that was looking for a review from... I'm not sure, maybe
> > Connie or Paolo.  Christian, is this specifically what you're ack'ing?  
> 
> My understanding was that Halil was ok in the end?

Yes, I'm OK with it provided it is merged after Jason's patch that makes
it a non-issue.

Regards,
Halil

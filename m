Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E45C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  3 Nov 2021 13:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA08661076
	for <linux-s390@archiver.kernel.org>; Wed,  3 Nov 2021 13:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKCNUn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:20:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230152AbhKCNUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Nov 2021 09:20:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3DGjqN013418
        for <linux-s390@vger.kernel.org>; Wed, 3 Nov 2021 13:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BGLDeRVo6pzqkFTgR0Oqs5Ab4DXnCvCD6MnlUvq7nQM=;
 b=bCoYvA8tm/zcHPjuJcPIFwNXrBc5Ws8Wj98cAQoqHpLReiuE/1Du5pJfMhERCFXxxsUC
 pwz9IWSMk+lFRyCRLOO5XXdPVwzVTpmWsed4wm4Wm2iuXop0ViQxWlXuvU05Dycl/cVz
 kVFv8O3ySLr8Qgz5sIDxJ5dDHANz6gyu+kCJKGOVb9SSe9q3YHf4vhUPdsrjvkSyR60B
 QdY8gRz+FWJgRcBtaQTZ/Hj8pFYtY8r/K4+7ulN7LVeuY4RppCyT7OTnGDr981LPcIpf
 bdtgP0s9CnxfW+faykFyjWUMIpMybISVCWfgpX7mGIbTLS5/Evt1aUnwoPzxdhweirxw JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3u5x8142-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 03 Nov 2021 13:18:06 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A3DGtCI013991
        for <linux-s390@vger.kernel.org>; Wed, 3 Nov 2021 13:18:05 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c3u5x813a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 13:18:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A3DF7v0003893;
        Wed, 3 Nov 2021 13:18:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3c0wajnpkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 13:18:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A3DI0Wd62390626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Nov 2021 13:18:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 385B6AE045;
        Wed,  3 Nov 2021 13:18:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D71C5AE051;
        Wed,  3 Nov 2021 13:17:58 +0000 (GMT)
Received: from li-748c07cc-28e5-11b2-a85c-e3822d7eceb3.ibm.com (unknown [9.160.129.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Nov 2021 13:17:58 +0000 (GMT)
Message-ID: <3ab690456a523951ad59c17ac71e6b294ff12d98.camel@linux.ibm.com>
Subject: Re: [RFC v2 0/1]s390/cio: remove uevent suppress from cio driver
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com
Date:   Wed, 03 Nov 2021 14:17:57 +0100
In-Reply-To: <87lf26bmlq.fsf@redhat.com>
References: <20211027085059.544736-1-vneethv@linux.ibm.com>
         <87lf26bmlq.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fLFN7vHod-FfMXED7eJPaChCRlHb7l3w
X-Proofpoint-GUID: urtiTDeL-DAFVnnz6XY0JLWwQ5XKpd0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_04,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Thank you Conny for looking in to this.

On Tue, 2021-11-02 at 16:31 +0100, Cornelia Huck wrote:

...snip...
> device has bound to a driver, which was an information that was
> completely missing up to now for subchannels. The main issue is that the
> subchannel will get deregistered again (or has that been changed? Sorry,
> I've been out of the loop for too long...)
You are right. There is a change and we do not unregister the subchannel if we
find the corresponding device is not operational or empty.

...snip...
> > I think the potentially problematic case is "lots of I/O subchannels
> with no valid device", and I think you can't get that under z/VM (which
> will not give you those subchannels in the first place), but only on LPAR.
Yes. But, this is in case of actual device. I just defined around 5k virtual
dasd devices on zVM and did not enable them. i.e those subchannels are not
blacklisted anymore, but they does not have an operational device. 

other than zVM, other than testing this patch on different available LPARs,
we tried to mimic the device availability with a custom test-kernel.
Basically, modified the subchannel initialization code and inform the subchannel
about the presence of a device, which then later fails during SNSID.
It is a horrid way to test it, but i think it could simulate some LPARs with
more than 1000 non-operational devices connected on it.

...snip...

> - non-I/O subchannels (IIRC you can't have CHSC subchannels under z/VM,
>   don't know about EADM, so that would need to be done on an LPAR as
>   well)
Thanks. Most of my tests were on IO-subchannel. I shall try few tests on CHSC
and EADM.

> - interaction with driverctl (and maybe mdevctl) for vfio-ccw
I have done couple of tests with driverctl. Also, i was wondering if vfio-ccw
can make use of 'dev_busid' sysfs-interface under each subchannels while writing
the rules. This is totally different topic, which i do not want to mix up in
this thread.

...snip...


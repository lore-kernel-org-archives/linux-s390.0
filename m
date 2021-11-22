Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA40C433F5
	for <linux-s390@archiver.kernel.org>; Mon, 22 Nov 2021 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhKVNjp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:39:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhKVNjp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Nov 2021 08:39:45 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMCVL4N026583
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 13:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TzC3MQrh2G8jTuOKXK/07MO370JlgvjK79m7C1OBhz0=;
 b=DJ4SjeyE8YKuW9XdsV0L0xUDfTRdYHJQf5xU8z31+IekpzDUIOXVkm6tUET79MKzjSaU
 TWzIq9PyiMmhRcVB6udRSQp1TUr1X+fAL4fQrLrsPi23/a7u1livCMhN96h6PRwWMkKb
 OkPXOuie+uyfjgNJ6MM7HAXKrx3hyysHevdoPT3AZUDMJwlUWylTLT9E7R2i06WhVCAx
 yODsV5+m5yfCWFC++fZ5By/kpXafdGNBb/+ZjYYmS05XhpfTom9kpM7x+b9NpPnwrWyG
 zO1Q5Ug3WPW7sRpEdp2F55rjkdMGjDHu9DGMGbB2IK8TLAPQI4/JNFAeOJIWnuCNy68I rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgb3qsrwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 13:36:38 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AMConSM000893
        for <linux-s390@vger.kernel.org>; Mon, 22 Nov 2021 13:36:38 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgb3qsrvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 13:36:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AMDInr0021679;
        Mon, 22 Nov 2021 13:36:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3cernax1rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 13:36:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AMDaV8v64487822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 13:36:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97CD0AE061;
        Mon, 22 Nov 2021 13:36:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79388AE051;
        Mon, 22 Nov 2021 13:36:31 +0000 (GMT)
Received: from [9.145.181.139] (unknown [9.145.181.139])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Nov 2021 13:36:31 +0000 (GMT)
Message-ID: <2db0176d-ab52-8ea9-3fb0-6190f4198c2c@linux.ibm.com>
Date:   Mon, 22 Nov 2021 14:36:31 +0100
MIME-Version: 1.0
Subject: Re: [RFC v3 1/1] s390/cio: remove uevent suppress from cio driver
Content-Language: en-US
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, cohuck@redhat.com,
        linux-s390@vger.kernel.org
References: <20211122103756.352463-1-vneethv@linux.ibm.com>
 <20211122103756.352463-2-vneethv@linux.ibm.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20211122103756.352463-2-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gek7u_6AQPY0k_VoasnqtJw-OOSyPNEU
X-Proofpoint-ORIG-GUID: tdGtwjxMN0PgBXUcSwcpIUdO6UQeo9kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_07,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=904 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220071
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22.11.2021 11:37, Vineeth Vijayan wrote:
> commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")
> introduced suppression of uevents for a subchannel until after it is
> clear that the subchannel would not be unregistered again
> immediately. This was done to avoid uevents being generated for I/O
> subchannels with no valid device, which can happen on LPAR.
> 
> However, this also has some drawbacks: All subchannel drivers need to
> manually remove the uevent suppression and generate an ADD uevent as
> soon as they are sure that the subchannel will stay around. This misses
> out on all uevents that are not the initial ADD uevent that would be
> generated while uevents are suppressed; for example, all subchannels
> were missing the BIND uevent.
> 
> As uevents being generated even for I/O subchannels without an
> operational device turned out to be not as bad as missing uevents and
> complicating the code flow, let's remove uevent suppression for
> subchannel
> 
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> [cohuck@redhat.com: modified changelog]

Looks good to me!

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


Regards,
  Peter

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70EC2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CAA6141C
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 13:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhEYNFT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 09:05:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58235 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232862AbhEYNFS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 09:05:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PD2hET014840;
        Tue, 25 May 2021 09:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=TC0d2aXtZ9kOoBZa5c0YpJpsWVUyUFpCZuecZaZrDl8=;
 b=AXsIA/3RZ5O+k0Gj5ik/E84vZOyh6McWua3cNPy7nPXXHUaFKeHFxReUZXCoBrvVDzFq
 HJx9vc7kWhiXjwmU3OlR1lNmWWVcvPJEF1wBXLbntBD1ZmD3Nr6LPO1Z98AJOyeU2Muf
 zJ6TYtsWzmHkAF02d9OMFRRzBUegBKH+IbcIBvhxg9FlRVWWDHmUBAlUnnic6SfYPXwa
 Ev+4hcnnGidu6I8Unm1zFs/SNt2QQGwcU9jxEbvEPeJt534HPJtlMVFI1c3XcYnI/WeY
 hsMll9uV9JK6zM/y4ZSNe1rC6XtqsNwws1Cly7wE9tty0+0bjTyGpmSrZhqxPIz6PBJ2 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1g68qdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:03:46 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PD2nOu015774;
        Tue, 25 May 2021 09:03:46 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s1g68qcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 09:03:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PD2xXJ015238;
        Tue, 25 May 2021 13:03:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 38s1rv801a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 13:03:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PD3CLK30474674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 13:03:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9DAAE04D;
        Tue, 25 May 2021 13:03:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76996AE045;
        Tue, 25 May 2021 13:03:40 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.33.143])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 25 May 2021 13:03:40 +0000 (GMT)
Date:   Tue, 25 May 2021 15:03:37 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v4 1/2] s390/vfio-ap: fix memory leak in mdev remove
 callback
Message-ID: <20210525150337.021aabd8.pasic@linux.ibm.com>
In-Reply-To: <20210521193648.940864-2-akrowiak@linux.ibm.com>
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
        <20210521193648.940864-2-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ayilL24a_T5e9lLRfW6oebhybfsTkuj6
X-Proofpoint-ORIG-GUID: Jvuzbuj2Sx4nOdw6LW5EnpgKIHIkDBQx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_06:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 21 May 2021 15:36:47 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The mdev remove callback for the vfio_ap device driver bails out with
> -EBUSY if the mdev is in use by a KVM guest. The intended purpose was
> to prevent the mdev from being removed while in use; however, returning a
> non-zero rc does not prevent removal. This could result in a memory leak
> of the resources allocated when the mdev was created. In addition, the
> KVM guest will still have access to the AP devices assigned to the mdev
> even though the mdev no longer exists.
> 
> To prevent this scenario, cleanup will be done - including unplugging the
> AP adapters, domains and control domains - regardless of whether the mdev
> is in use by a KVM guest or not.
> 
> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

AFAIU we all agree that, after patch there is a possibility for an use
after free error. I'm a little confused by the fact that we want this
one for stable, but the patch that fixes the use after free as no
Cc stable (it can't have a proper fixes tag, because this one is not yet
merged). Actually I'm not a big fan of splitting up patches to the
extent that when not all patches of the series are applied we get bugous
behavior (e.g. patch n breaks something that is live at patch n level,
but it is supposed to be OK, because patch n+m is going to fix it (where
n,m \in \Z^{+}).

Do we want to squash these? Is the use after free possible prior to this
patch? 

Regards,
Halil

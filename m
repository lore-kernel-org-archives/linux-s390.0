Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A41C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A8561213
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 09:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhJDJ12 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:27:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhJDJ12 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 05:27:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1949Ah0U001135;
        Mon, 4 Oct 2021 05:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=vT7qGkc73f3PD6OnZ7iIGB4BRYsxeKDvvH9yz1S3no8=;
 b=HlViD0Py3eqjU2i7lAtCb4gWDrj8WrzE86g/KW8E68PvJLN+0XEGerwb5lUljQBn+t8n
 nJGtbOuEt2GWsaJZehqT4jefa/T72yeNotNAumP989/62AtxjECdfB8jGDjWuxCpPqbn
 WYPtK+hltZKbfBuVYWMwsrxr7l3qXKM9JhBX8v8NTvEn5faqJtCdZ8Fe/bXg3T8jo7mV
 TXW6PohkE5uv9JudPtqYL72+deBqlMLhgRo4VMCQjrU5pf421SqPqwX1nw8/kH9cybYr
 fWEssois8qryrlRrjScMxR1JzNVUrlseYGyBNXlj6eR10/SDBpDRpy/CjQ+/57ypiyxn nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bfxdt8f4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 05:25:37 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1949PbiW025706;
        Mon, 4 Oct 2021 05:25:37 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bfxdt8f3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 05:25:37 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1949CTXJ019358;
        Mon, 4 Oct 2021 09:25:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3bef29krwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 09:25:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1949KEII18547180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 09:20:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EF5952052;
        Mon,  4 Oct 2021 09:25:31 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.45.119])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 93E5952050;
        Mon,  4 Oct 2021 09:25:30 +0000 (GMT)
Date:   Mon, 4 Oct 2021 11:25:28 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211004112528.74442e52.pasic@linux.ibm.com>
In-Reply-To: <87pmsl2rzd.fsf@redhat.com>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
        <87r1d64dl4.fsf@redhat.com>
        <20210930130350.0cdc7c65.pasic@linux.ibm.com>
        <87ilyi47wn.fsf@redhat.com>
        <20211001162213.18d7375e.pasic@linux.ibm.com>
        <87v92g3h9l.fsf@redhat.com>
        <20211002082128-mutt-send-email-mst@kernel.org>
        <87pmsl2rzd.fsf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iSY6NboaJgOAOYom2ahH_CQcl1msSaq2
X-Proofpoint-ORIG-GUID: wcV1khcVsbws-U_qnZdOO6FoCTCcQvQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_02,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040063
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 04 Oct 2021 09:01:42 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:  
> >> I'd say we need a hack here so that we assume little-endian config space
> >> if VERSION_1 has been offered; if your patch here works, I assume QEMU
> >> does what we expect (assmuming little-endian as well.) I'm mostly
> >> wondering what happens if you use a different VMM; can we expect it to
> >> work similar to QEMU?  
> >
> > Hard to say of course ... hopefully other VMMs are actually
> > implementing the spec. E.g. IIUC rust vmm is modern only.  
> 
> Yes, I kind of hope they are simply doing LE config space accesses.
> 
> Are there any other VMMs that are actually supported on s390x (or other
> BE architectures)?
> 

I think zCX (z/OS Container Extensions) is relevant as it uses virtio.
That is all I know about.

Regards,
Halil

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE04C07E99
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jul 2021 23:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14ADC606A5
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jul 2021 23:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGLXlZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Jul 2021 19:41:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230043AbhGLXlY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Jul 2021 19:41:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CNY2R5155219;
        Mon, 12 Jul 2021 19:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ulZMDs+iXBTD7zlMWPyz9dR2LBvAM2HZN3VduqwhmtQ=;
 b=K0kHLQGqBQvHjd+bQ4/Fpqb8AFGQA61KcPi1aphQ1oVw2gBkmik5TV0HYd30QabDfW4C
 OdA6OTcPa+etY66l/W2W6Ni2bhTrug/yrzu9RSWLwzU0J6DUXTJBYRYVNKIw4TpXcXvL
 C/3FRc/jpt8GIJIG3Rt//kKFNoIh7N3MLqmeQ4v/h5XwL3uHn1L/HFTJ5e15m6PRmC8l
 pYquHkCsBA0myK/3ITFeGsWl8rVeK5IKTwHyxkPDVKkD06P9UEVUoLfoIgNm91pc4Ig7
 KznJ4ZasGJ763sy1vP/8KlbNDnEXsXQNucnv8rOKCw9EKm+3fhd8yXDUvC2zgSj+HAHI 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs2vhxjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 19:38:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CNYUcl156147;
        Mon, 12 Jul 2021 19:38:32 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qs2vhxj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 19:38:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CNXRiE021935;
        Mon, 12 Jul 2021 23:38:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39q3688yky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 23:38:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CNcQVB27197698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 23:38:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FB59AE056;
        Mon, 12 Jul 2021 23:38:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A23BAE053;
        Mon, 12 Jul 2021 23:38:25 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.38.94])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 12 Jul 2021 23:38:25 +0000 (GMT)
Date:   Tue, 13 Jul 2021 01:38:15 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210713013815.57e8a8cb.pasic@linux.ibm.com>
In-Reply-To: <20210707154156.297139-1-akrowiak@linux.ibm.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CIgMDj5PHlNuppKgQ2pjdngNUNlPvsTD
X-Proofpoint-GUID: GrPPd0Hiiyaa667Lp2Y7ATqxK_iUBbcm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_14:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120160
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  7 Jul 2021 11:41:56 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> It was pointed out during an unrelated patch review that locks should not
> be open coded - i.e., writing the algorithm of a standard lock in a
> function instead of using a lock from the standard library. The setting and
> testing of the kvm_busy flag and sleeping on a wait_event is the same thing
> a lock does. Whatever potential deadlock was found and reported via the
> lockdep splat was not magically removed by going to a wait_queue; it just
> removed the lockdep annotations that would identify the issue early

Did you change your opinion since we last talked about it? This reads to
me like we are deadlocky without this patch, because of the last
sentence.

Regards,
Halil

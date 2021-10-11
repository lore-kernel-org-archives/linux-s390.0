Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D0C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B05C60E74
	for <linux-s390@archiver.kernel.org>; Mon, 11 Oct 2021 10:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhJKKL4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Oct 2021 06:11:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235712AbhJKKLz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Oct 2021 06:11:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B93D5I021367;
        Mon, 11 Oct 2021 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NTo+Y1D5Epgvi7xoHstSjuE14iI/mfWJPFBA+O2eVCg=;
 b=ZOdpy1FkJYnuHY0DQFdSn6zAnI9VDQwDmRrHXJVZqjErHDw5ZW9f19JTwnoGRJcHudFw
 bbKg0l3aleUvtWGbD87uZZG/E3JjYRIOFgJndQzKxrmY24VSMSDGV2vKqsi2JjzORLWe
 Teuxm45ujl3Fmx8sYJbb9jH/WOILLolUGyKUB6s45cagLYjNZb/e+EnFcHEnOeU7Qq+w
 krlbceS9eDe5GPTPhNf268iM1cGYDdu7DVKcFkTSGJ+iQaEtv3/l0jkl1Op7v0Ufi/uH
 sQBIpS1gep2SCXbPjWi+TR8b3pjAKZ1FEW54q/Sfx9LryIo+hq9vtdqRd9zTly+lGBW/ Cg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bmj9s1an1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 06:09:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19BA3MY7021676;
        Mon, 11 Oct 2021 10:09:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3bk2q9kecb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 10:09:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19BA9hoM36438396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 10:09:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FE2E11C06E;
        Mon, 11 Oct 2021 10:09:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16E4811C05B;
        Mon, 11 Oct 2021 10:09:43 +0000 (GMT)
Received: from osiris (unknown [9.145.33.245])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Oct 2021 10:09:43 +0000 (GMT)
Date:   Mon, 11 Oct 2021 12:09:41 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YWQNZb25R3SjsQAL@osiris>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris>
 <c372092aecc243ad880ea9a5bdf7d080@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c372092aecc243ad880ea9a5bdf7d080@AcuMS.aculab.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5yOyESKx_pJyfNgYlqoTdKL1BujR8wtm
X-Proofpoint-ORIG-GUID: 5yOyESKx_pJyfNgYlqoTdKL1BujR8wtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=943 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110057
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 11, 2021 at 08:21:15AM +0000, David Laight wrote:
> ...
> > > +	 * This snprintf() call does two things:
> > > +	 * - makes a NUL-terminated copy of the input string
> > > +	 * - pads it with spaces
> > > +	 */
> > > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> > 
> > I can't say I like code where I have to count spaces in order to
> > verify if the code is actually correct.
> 
> What it wrong with "%-8.8s" ?

There's nothing wrong with it, except lack of imagination on my side ;)
Andy, care to to send a separate patch just for extmem.c?

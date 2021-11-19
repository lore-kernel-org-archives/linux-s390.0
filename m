Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94FAC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FC461ACE
	for <linux-s390@archiver.kernel.org>; Fri, 19 Nov 2021 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKSPSq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:18:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhKSPSq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Nov 2021 10:18:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJEhTMc013187;
        Fri, 19 Nov 2021 15:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Hem8SWJOKVrd93edFuJdHTtCDFEJi00P6XmWiu+Mad4=;
 b=GdCZkqjH22v5VQfLeAc//cZ5shSGR0evNu8BNA4UbURc1I6DfAtBHCAh5liafJWRyJoU
 TfUH89vmR/fhRoSO79Jj8dfU6dB8aYH8BZWgenuiXwYlq+idwleTmZV2pf4aNvSLhZCj
 Nd4vC25eeREc+wWYhf/2+9/wsmE8dk8y9FDmy6J7W6uuoT9U6G49vxSnX60Td946osys
 qzSY+WeBkFJPijCEjB9vZGUG5S/OLm4jIRir5lm5TeCdLdlNZGyD20GW95dHY8MJBa3r
 Cytm1zNFgC7mC/pJMMuHoDeCNpjIbdMhw0bUrTSARZs0zmLyvOv7JBqTzKQKlKqx54TM 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cedxjrpqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:15:41 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJEt7I3029187;
        Fri, 19 Nov 2021 15:15:41 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cedxjrppg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:15:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJFDkPA001798;
        Fri, 19 Nov 2021 15:15:38 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3ca50ayfg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 15:15:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJF8Ult60359084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 15:08:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C9F5AE057;
        Fri, 19 Nov 2021 15:15:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1634AE051;
        Fri, 19 Nov 2021 15:15:32 +0000 (GMT)
Received: from osiris (unknown [9.145.50.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Nov 2021 15:15:32 +0000 (GMT)
Date:   Fri, 19 Nov 2021 16:15:31 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid
 instruction
Message-ID: <YZe/k+uxjdT6+OV5@osiris>
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
 <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
 <d9ec2704-f41c-eafa-1945-ce845d65be8a@de.ibm.com>
 <YZeCcSjh4yCzzDcH@osiris>
 <658a63b5-2d18-2837-9639-75a14c959f73@de.ibm.com>
 <YZeF4JjWIcTMtaaT@osiris>
 <fe1662f9-7cab-5f9f-882b-2b8ffa80992c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1662f9-7cab-5f9f-882b-2b8ffa80992c@de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fIMRs12fhuACsvoGGtz18RJkCYtUztZc
X-Proofpoint-GUID: kbBazBqKHYf-wjWGgLqCcSod-7Yh9K4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxlogscore=873 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 19, 2021 at 03:12:03PM +0100, Christian Borntraeger wrote:
> Am 19.11.21 um 12:09 schrieb Heiko Carstens:
> > On Fri, Nov 19, 2021 at 11:57:05AM +0100, Christian Borntraeger wrote:
> > > > > > > -                       "       mvcl    %%r1,%%r1\n"
> > > > > > > +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
> > > > 
> > > > Sorry, I disagree with this. As you said above rr would be the correct
> > > > format for this instruction. If we go for the e format then we should
> > > > also use an instruction with e format.
> > > > Which in this case would simply be an illegal opcode, which would be
> > > > sufficient for what this code is good for: ".insn e,0x0000".
> > > 
> > > Why not simply use .short then?
> > 
> > .short bypasses all sanity checks while .insn does not, so I think
> > that should be preferred. But I don't care too much.
> 
> Heiko,
> I am fine with ".insn e,0x0000" and the a changed comment that
> changes "specification exception" to "operation exception".  Do you
> want Ilie to resend or simply fixup?

I'll simply change it. Let's don't spend more time on this.

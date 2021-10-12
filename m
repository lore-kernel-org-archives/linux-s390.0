Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E664C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 09:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D41361078
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhJLJO2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:14:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232502AbhJLJO1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 05:14:27 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C8gFWN023071;
        Tue, 12 Oct 2021 05:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MIH7MWUn5vJZX39nwodbJORz2WPIGlaALqP0WppLcj4=;
 b=RnUes36uz2B7EmEmsC6yW6LScrm1+YaGWWWZ01cyRC4zlB0wBFb/j2nHfBf+QUuIY40i
 oVDyJjHzDc1mC6JHqNWRGgR1QrzsfRAL9XWwtWmmP/NbW6OwcMaFJ8GVpRIGRVyIMET1
 d624NFeZyjxoNRO+qTGYFqj/cKBIPQJN37EaihPldLdAIR/z1k7IbyuIQVExUn8PqxtG
 2q18WBbKmuSKEbxrV8iHbEbn+Kj5QkSVlZIVqM6r3tBzDtcngGrOFqxYkHD5wq2//EHo
 YI6V2NZGZSh4PVl4gt3nHdStdw1VBQ3ZsPjdZSZVGSwlbfhmGFCVNynXvjuxwMqJaZta 9A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn72x0hxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 05:12:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C97P2u006745;
        Tue, 12 Oct 2021 09:12:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2q9xdba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:12:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C9CFXo3605168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 09:12:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9761BAE051;
        Tue, 12 Oct 2021 09:12:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D77CAE045;
        Tue, 12 Oct 2021 09:12:15 +0000 (GMT)
Received: from osiris (unknown [9.145.173.66])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Oct 2021 09:12:15 +0000 (GMT)
Date:   Tue, 12 Oct 2021 11:12:13 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YWVRbQrDk7jtYApD@osiris>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris>
 <c372092aecc243ad880ea9a5bdf7d080@AcuMS.aculab.com>
 <YWQNZb25R3SjsQAL@osiris>
 <985bbceb3ee046bbbee6199efcf7c90c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985bbceb3ee046bbbee6199efcf7c90c@AcuMS.aculab.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IJcfOqBw4ZieZn-YQMxkOYYGyjGrdiYb
X-Proofpoint-GUID: IJcfOqBw4ZieZn-YQMxkOYYGyjGrdiYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_02,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120051
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 12, 2021 at 08:04:58AM +0000, David Laight wrote:
> From: Heiko Carstens
> > Sent: 11 October 2021 11:10
> > 
> > On Mon, Oct 11, 2021 at 08:21:15AM +0000, David Laight wrote:
> > > ...
> > > > > +	 * This snprintf() call does two things:
> > > > > +	 * - makes a NUL-terminated copy of the input string
> > > > > +	 * - pads it with spaces
> > > > > +	 */
> > > > > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> > > >
> > > > I can't say I like code where I have to count spaces in order to
> > > > verify if the code is actually correct.
> > >
> > > What it wrong with "%-8.8s" ?
> > 
> > There's nothing wrong with it, except lack of imagination on my side ;)
> > Andy, care to to send a separate patch just for extmem.c?
> 
> Are any of the snprintf() versions actually correct at all?
> The implication of the comment is that the input string might
> not be NUL terminated - in which case it shouldn't be passed
> to snprintf().
> I don't think you can assume that the format processing doesn't
> do a strlen() of any %s argument - even if a maximum field
> width is given.

The input string is a NUL terminated ASCII string. The output string
is not. It is used to communicate with a hypervisor, which expects an
eight character EBCDIC non NUL terminated name, where the name is
either eight characters long or filled up with spaces.
So using snprintf here should be fine. On the other hand I really
don't see a pressing need to change anything here.

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58BDC433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A3613B5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 08:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhJEI42 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:56:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232739AbhJEI42 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 04:56:28 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1958g3Qw024789;
        Tue, 5 Oct 2021 04:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Oc3GvTQfzksAh7Ij8tpg94WjZ7As1pYxcRGBnzkR4T8=;
 b=dLgwPOutMeYkpMw37ClaXMEdDAhlIkT/sBzRFGJZP/hZwpKBXQEi2lK30JibLFAYXFfd
 a20t5DNCIjFefY1fj0Ve/fZSkSBBtFQcRnWEyfqKbqOnja0EikWUC+8ul8sdstrBnsLQ
 RkGtIjgZB6/Qx1wri6zKsCbmpQugUN1nLDIOH8dklslG3Q2/AY3MfNV5XCcG53r6IX6H
 VPseOXWo6UbTrB0welEAvKKBLF1yeS5nZ4Le7SiBUMrFdcaLw70z8EMkfyYr/7If7qK2
 kFUjDQC/4fN0SarBd6IJQqXgHDD5jKVpmaPy6PsTVY2+VPiKX5kOTsu5mPrRynBAiJtU jA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bgkdw86h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 04:54:36 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1958mWCG020471;
        Tue, 5 Oct 2021 08:54:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3beepjg740-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 08:54:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1958sUrU38994194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 08:54:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A4152065;
        Tue,  5 Oct 2021 08:54:30 +0000 (GMT)
Received: from osiris (unknown [9.145.46.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 64D205205F;
        Tue,  5 Oct 2021 08:54:30 +0000 (GMT)
Date:   Tue, 5 Oct 2021 10:54:28 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1 1/1] s390: Use string_upper() instead of open coded
 variant
Message-ID: <YVwSxGyx45gs2+ZW@osiris>
References: <20211001130201.72545-1-andriy.shevchenko@linux.intel.com>
 <YVtksmjj1eGqw5GY@osiris>
 <YVwKXn1Nqwk+Ahsx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVwKXn1Nqwk+Ahsx@smile.fi.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cPPcssBzOwyyeEHkFO6Sgkp5Pyo4XnJf
X-Proofpoint-GUID: cPPcssBzOwyyeEHkFO6Sgkp5Pyo4XnJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050049
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 11:18:38AM +0300, Andy Shevchenko wrote:
> On Mon, Oct 04, 2021 at 10:31:46PM +0200, Heiko Carstens wrote:
> > On Fri, Oct 01, 2021 at 04:02:01PM +0300, Andy Shevchenko wrote:
> > > +	/* Segment name is limited by 8 characters + NUL */
> > > +	char tmp[8 + 1];
> > >  	int i;
> > >  
> > > -	for (i = 0; i < 8; i++) {
> > > -		if (name[i] == '\0')
> > > -			break;
> > > -		dcss_name[i] = toupper(name[i]);
> > > -	}
> > > -	for (; i < 8; i++)
> > > -		dcss_name[i] = ' ';
> > > +	/*
> > > +	 * This snprintf() call does two things:
> > > +	 * - makes a NUL-terminated copy of the input string
> > > +	 * - pads it with spaces
> > > +	 */
> > > +	snprintf(tmp, sizeof(tmp), "%s        ", name);
> > 
> > I can't say I like code where I have to count spaces in order to
> > verify if the code is actually correct.
> 
> I understand your point, but have any idea how to make it differently
> and not ugly at the same time?

Don't know. You could use strncopy+strlen+memset (with space
character). After all I'm not very convinced that the resulting code
buys us anything compared to the current variant.

> > > +	string_upper(dcss_name, tmp);
> 
> ...
> 
> > >  static struct dcss_segment *
> > >  segment_by_name (char *name)
> > >  {
> > > -	char dcss_name[9];
> > > +	char dcss_name[8];
> > 
> > string_upper will copy the terminating NUL-byte. By reducing the size
> > of dcss_name to 8 bytes this will result in stack corruption.
> 
> Nope. Even in the original code this additional byte is left unused.

I'm talking about the new code, not the old code: If "name" points to
a NUL terminated eight chararacter string, then the new code will use
snprintf to copy it 1:1 to tmp, and the subsequent string_upper() will
copy the string (upper cased) to dcss_name, now including the NUL
terminating byte, which won't fit into dcss_name.
Am I missing something here?

Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72419C433FE
	for <linux-s390@archiver.kernel.org>; Mon,  6 Dec 2021 18:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhLFSjw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:39:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243255AbhLFSjw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Dec 2021 13:39:52 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HnvwG009971
        for <linux-s390@vger.kernel.org>; Mon, 6 Dec 2021 18:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xmf8+QgAr6ewS/C9/pvWjqHHh1PM/Tce6uwZTXK3ebA=;
 b=gT6cD2nc2Ozqe9HTcZklfBmwI1htjV/hBp4TMRg00eD6YawoBDUkF85whUFQHWskbjHU
 hX2GiCKiZ7Muvg+p/FF1LbZw+z6boCXnpLG7iQhQjTJyCOOxZrAZumxI8dP8lzz4kQt4
 oq74m4ZTSt3+5dAf9QyA547DfjHcV9X5S+BbEpKyvBmJMjUTKcwbXNDSw1NQ/kmoSiQh
 Dc5MrFwLSbn2dUS2x1duOzU4zzmBXDgZ6ZHcFzBorrF8FpkPxaTmjR3I+VZVBDdtq0pp
 A/I7oIKALAxTqdbowAXtcBgFtMXXlWbuK8MQ49XwMLCgivICEieoGDcBnpF9lfkQZQK0 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csh56hnv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Dec 2021 18:36:22 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6IOPFH007554
        for <linux-s390@vger.kernel.org>; Mon, 6 Dec 2021 18:36:22 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csh56hnu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 18:36:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6IX4Cr012779;
        Mon, 6 Dec 2021 18:36:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3cqyyafmyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 18:36:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6IScas25887206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 18:28:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF062A4040;
        Mon,  6 Dec 2021 18:36:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A46C6A4051;
        Mon,  6 Dec 2021 18:36:16 +0000 (GMT)
Received: from osiris (unknown [9.145.12.237])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 18:36:16 +0000 (GMT)
Date:   Mon, 6 Dec 2021 19:36:15 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH] s390/kexec_file: fix error handling when applying
 relocations
Message-ID: <Ya5YH2ouT35ehN1e@osiris>
References: <20211206112047.4746-1-prudo@redhat.com>
 <Ya5Ex8WPeyiPwXl+@osiris>
 <20211206183337.0aaf7d4c@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206183337.0aaf7d4c@rhtmp>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zi-0x6KvcuGz2R5vUkUf13l0bKnrlWuH
X-Proofpoint-ORIG-GUID: ysT3rMXJ7Yz95oIb64t-_rpTWG2Yq6kS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=971 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060111
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> > >  		r_type = ELF64_R_TYPE(relas[i].r_info);
> > > -		arch_kexec_do_relocs(r_type, loc, val, addr);
> > > +		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
> > > +		if (ret)
> > > +			return -EINVAL;  
> > 
> > I'd prefer if this would return -ENOEXEC, just to be consistent with
> > x86. And _maybe_ it would also make sense to print an error message,
> > including the failing relocation type?
> 
> sure, I'll update the return value to -ENOEXEC.
> 
> About the error message, I didn't add it on purpose as none of the
> other error cases print one. For consistency I would add one for those
> cases as well. Any objections?

No objections at all. This sounds good!

Thanks,
Heiko

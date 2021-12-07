Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDD2C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Dec 2021 15:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhLGPdg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Dec 2021 10:33:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238745AbhLGPde (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Dec 2021 10:33:34 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FIMha013362
        for <linux-s390@vger.kernel.org>; Tue, 7 Dec 2021 15:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tV6QQazSTp1j6OxmBFIzX75ikohjfH3xMX8fhNzYiIA=;
 b=mFFDj64ceZMHLnVGp0H9YMQ1ogrxpFbXS98xG1fsJmnXDUNZnljJKBsn03ul3LP9qYBp
 7valihtrGKAQ+ajB/7cIqNTLZi5cmuIz18b64LIxQcaIv/MeiK0HGvpAMW6xclilnXAU
 ZBOj8f7+Xpwr9sOyyhaa81avCbbeCTfJrZem0LwBOvENru/LlfrYco4J8tPseNvGnUXo
 MVdqvlzo6ZI9olhUbUI+7sn5ktjpfnvUmCMDbPXMzH/sy8kRswMom3ItwIH6yozTgX1Z
 SLpiemRsfJb/WPhCRooKKqLx+/O5O6PATcJqjJ9id91xwlI2Ws2uxzKozzd57D5n+393 jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cta4kr7qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 07 Dec 2021 15:30:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7FL8MI020126
        for <linux-s390@vger.kernel.org>; Tue, 7 Dec 2021 15:30:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cta4kr7pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:30:02 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FSpN1025514;
        Tue, 7 Dec 2021 15:30:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3cqyy9eqn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 15:30:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7FTvqh32309600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 15:29:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9108CA405C;
        Tue,  7 Dec 2021 15:29:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535CDA4054;
        Tue,  7 Dec 2021 15:29:57 +0000 (GMT)
Received: from osiris (unknown [9.145.146.206])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Dec 2021 15:29:57 +0000 (GMT)
Date:   Tue, 7 Dec 2021 16:29:55 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH v2 1/2] s390/kexec_file: print some more error messages
Message-ID: <Ya9988i7o788He/z@osiris>
References: <20211207125749.6998-1-prudo@redhat.com>
 <20211207125749.6998-2-prudo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207125749.6998-2-prudo@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klAx78RTOVqHoA4Q5D6ew3ysjh5FCSHJ
X-Proofpoint-ORIG-GUID: ROKW6vn6m--EiFYamdNyJft8gXsnrzj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=972 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070091
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Philipp,

On Tue, Dec 07, 2021 at 01:57:48PM +0100, Philipp Rudo wrote:
> Be kind and give some more information on what went wrong.
> 
> Signed-off-by: Philipp Rudo <prudo@redhat.com>
...
> @@ -304,15 +306,22 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  		sym = (void *)pi->ehdr + symtab->sh_offset;
>  		sym += ELF64_R_SYM(relas[i].r_info);
>  
> -		if (sym->st_shndx == SHN_UNDEF)
> +		if (sym->st_shndx == SHN_UNDEF) {
> +			pr_err("Undefined symbol\n");
>  			return -ENOEXEC;
> +		}
>  
> -		if (sym->st_shndx == SHN_COMMON)
> +		if (sym->st_shndx == SHN_COMMON) {
> +			pr_err("symbol in common section\n");
>  			return -ENOEXEC;
> +		}
>  
>  		if (sym->st_shndx >= pi->ehdr->e_shnum &&
> -		    sym->st_shndx != SHN_ABS)
> +		    sym->st_shndx != SHN_ABS) {
> +			pr_err("Invalid section %d for symbol\n",
> +			       sym->st_shndx);
>  			return -ENOEXEC;

So, if you add the additional error messages here, then I'd really
like to see also the name of the symbol which is causing
problems. Just like it is done on x86.
Sorry for nitpicking :)

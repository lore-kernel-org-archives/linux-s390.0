Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99929C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Dec 2021 17:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhLFRRT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:17:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231934AbhLFRRT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Dec 2021 12:17:19 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6FmeNb027823
        for <linux-s390@vger.kernel.org>; Mon, 6 Dec 2021 17:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eb7an9fcMAHoqAhaMLyJbrM5WhAJHuqmTlCb2b6yDus=;
 b=Genv6G73QLmTU6AA4gUDVmlnGDfpRYTD7PLgvlHqwsL9AhiI6SN4ssukHUEfmUAuphmk
 NUmgZqBeisJxxnTvjux50jHJhuVhof2HrZUGS78FK8xghyvmUrixRJCpif40D87hAhbL
 htcAchKcDnsa4J3jJnDBd6vETu1aFCsyOfc82IQMZX1JN+nBEHxbsNbFtVgBusBOXZmm
 a2JoeZ8vCXKMpwS+tKYE1d5GTKIImxS6MWaFlvcME1IeccyIQiGEEgPf1cQ+ush6qIQB
 +6Nf9F7bpzBr3lh0ktDqBOfoXZfM4DbhmqNFdnJ8iRxAOqmT43hCIMUpARdO3M9fc18T Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csn61j49u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Dec 2021 17:13:50 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6GxD6h018077
        for <linux-s390@vger.kernel.org>; Mon, 6 Dec 2021 17:13:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csn61j499-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:13:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HDigG030562;
        Mon, 6 Dec 2021 17:13:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3cqyy9edpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:13:47 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HDiBa26804528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:13:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA93A4C046;
        Mon,  6 Dec 2021 17:13:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99EC24C05E;
        Mon,  6 Dec 2021 17:13:44 +0000 (GMT)
Received: from osiris (unknown [9.145.12.237])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Dec 2021 17:13:44 +0000 (GMT)
Date:   Mon, 6 Dec 2021 18:13:43 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     linux-s390@vger.kernel.org, egorenar@linux.ibm.com, ltao@redhat.com
Subject: Re: [PATCH] s390/kexec_file: fix error handling when applying
 relocations
Message-ID: <Ya5Ex8WPeyiPwXl+@osiris>
References: <20211206112047.4746-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206112047.4746-1-prudo@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sCP8VaqrbmIizps-htJm3YWFu7PzfmuY
X-Proofpoint-ORIG-GUID: qxIM-V-xLvppxZL1QhY6wT-FPSI5R9mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Dec 06, 2021 at 12:20:47PM +0100, Philipp Rudo wrote:
> arch_kexec_apply_relocations_add currently ignores all errors returned
> by arch_kexec_do_relocs. This means that every unknown relocation is
> silently skipped causing unpredictable behavior while the relocated code
> runs. Fix this by checking for errors and fail kexec_file_load if an
> unknown relocation type is encountered.
> 
> The problem was found after gcc changed its behavior and used
> R_390_PLT32DBL relocations for brasl instruction and relied on ld to
> resolve the relocations in the final link in case direct calls are
> possible. As the purgatory code is only linked partially (option -r)
> ld didn't resolve the relocations leaving them for arch_kexec_do_relocs.
> But arch_kexec_do_relocs doesn't know how to handle R_390_PLT32DBL
> relocations so they were silently skipped. This ultimately caused an
> endless loop in the purgatory as the brasl instructions kept branching
> to itself.
> 
> Fixes: 71406883fd35 ("s390/kexec_file: Add kexec_file_load system call")
> Reported-by: Tao Liu <ltao@redhat.com>
> Signed-off-by: Philipp Rudo <prudo@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 9975ad200d74..0e1d646207dc 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -292,6 +292,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  {
>  	Elf_Rela *relas;
>  	int i, r_type;
> +	int ret;
>  
>  	relas = (void *)pi->ehdr + relsec->sh_offset;
>  
> @@ -326,7 +327,9 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  		addr = section->sh_addr + relas[i].r_offset;
>  
>  		r_type = ELF64_R_TYPE(relas[i].r_info);
> -		arch_kexec_do_relocs(r_type, loc, val, addr);
> +		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
> +		if (ret)
> +			return -EINVAL;

I'd prefer if this would return -ENOEXEC, just to be consistent with
x86. And _maybe_ it would also make sense to print an error message,
including the failing relocation type?

Thanks,
Heiko

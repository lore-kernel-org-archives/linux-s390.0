Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C7C433FE
	for <linux-s390@archiver.kernel.org>; Mon, 14 Nov 2022 08:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiKNIzr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Nov 2022 03:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiKNIzp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Nov 2022 03:55:45 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44801C93C
        for <linux-s390@vger.kernel.org>; Mon, 14 Nov 2022 00:55:43 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AE8reYa037438;
        Mon, 14 Nov 2022 08:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iXNBR1LAMlkcRoctf3B1pyNQUDYrVAPQRdFEOXunoAI=;
 b=o7lgn2N6VrAiW5QAyitFfcsbQbTsQSsO92Bp09CBy0/DNH9FC9c2Uap7gOFIjDc6EFkT
 H5kBaEWNJPIIzdVHad+bTIEdhFSe2DpjLqFUzTUQuz3f92hlAU9/3WmPl0PovY74SjJR
 2ORHJIkHWZXU+5W1l+6AhoUl23c29QSS/lL9jXS1628NGYKleB0jOAHp4AIrkfllvhdd
 LHfNKRKWKcqugRp1eZJhfk2x9RGL2WOZ+11p0h9xJUHXZ04dCLnFXk3lFj8mJFv1Rkbr
 nZytbzSsIArjtmGNX7iFweVAk3DoEDrPu5fK5KnLr1w0s+CL35LUQOCVqM8KSVb+6nBR vg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kujj98199-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 08:55:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AE8oLti031287;
        Mon, 14 Nov 2022 08:55:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3kt2rja9mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 08:55:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AE8tQmN37421492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 08:55:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F088DAE053;
        Mon, 14 Nov 2022 08:55:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7AABAE045;
        Mon, 14 Nov 2022 08:55:25 +0000 (GMT)
Received: from sig-9-145-2-197.uk.ibm.com (unknown [9.145.2.197])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 08:55:25 +0000 (GMT)
Message-ID: <b7ec3c33bb8e356fe29f3433002cb31f8013be74.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: Use irq_data_get_msi_desc()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Date:   Mon, 14 Nov 2022 09:55:25 +0100
In-Reply-To: <8735aoui07.ffs@tglx>
References: <8735aoui07.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rHwhZcE7poIRwDgBujWYLdvvvjlhorJK
X-Proofpoint-GUID: rHwhZcE7poIRwDgBujWYLdvvvjlhorJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_07,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=943 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140062
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 2022-11-12 at 19:47 +0100, Thomas Gleixner wrote:
> No point in doing another lookup of irq_data, it's already provided as
> an argument.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/s390/pci/pci_irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -132,7 +132,7 @@ static int zpci_clear_irq(struct zpci_de
>  static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *dest,
>  				 bool force)
>  {
> -	struct msi_desc *entry = irq_get_msi_desc(data->irq);
> +	struct msi_desc *entry = irq_data_get_msi_desc(data);
>  	struct msi_msg msg = entry->msg;
>  	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
>  

Thanks for the patch, makes sense to me so have my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

That said it must be noted that this function is only called when using
directed PCI IRQs which is a hardware feature that has not made it to
any released hardware. Nevertheless no point int doing things more
complicated than necessary even for that case.

If there are no objections I'll apply this to our internal tree and it
will then go upstream via the s390 tree.


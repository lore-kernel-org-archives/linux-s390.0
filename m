Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CC2C4332F
	for <linux-s390@archiver.kernel.org>; Mon, 14 Nov 2022 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiKNJhU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKNJhS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Nov 2022 04:37:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D7CE3A
        for <linux-s390@vger.kernel.org>; Mon, 14 Nov 2022 01:37:18 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AE9Psqv022354;
        Mon, 14 Nov 2022 09:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=U8MD3g8CjNL3onue3YZVhbdHrdVCae2JX5DPT2hhl6o=;
 b=oQoofdqlTfDTmgepY6Bwq5H42gBTplQlxqSj28Zl5Oa5903EMi5DXpEQRqfYxZC0Jp6d
 D0zZKBW6CqN3SrxRdf8HKht+dhfn+hWwz//p4R+WGHXmIbcg1n7+TxYZivK4M/EzGBh5
 9GV+FPccVSeFn+JlZuKNro/M8fgf+zYKpHfk9SD8pktXcuGSghUP/hMQJkL1krH0Hlvr
 s4jGuufK1WyneYAfVNSkq5Qz78M6yxwYqW6QZYL7kZWc6+WSo7QBmwwdOkdVNvKrEmrF
 I8Vn7Yb61poxIypzhLnDszKS4Kqz07jO0lTy87cgkL6R+IbY7ov8rwxLTnIyxv5j+jzM Qw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kuk1f08r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 09:37:07 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AE9a54m016058;
        Mon, 14 Nov 2022 09:37:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3kt2rj1pw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 09:37:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AE9b10U35783192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 09:37:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 982A95204F;
        Mon, 14 Nov 2022 09:37:01 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.163.92.18])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 6635B5204E;
        Mon, 14 Nov 2022 09:36:59 +0000 (GMT)
Date:   Mon, 14 Nov 2022 10:36:55 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: Use irq_data_get_msi_desc()
Message-ID: <Y3IMNx+QFY/P6eCA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <8735aoui07.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735aoui07.ffs@tglx>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: evw1xJyQXemF9e3FianQIlB82QZzlX_9
X-Proofpoint-GUID: evw1xJyQXemF9e3FianQIlB82QZzlX_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_07,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140070
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Nov 12, 2022 at 07:47:52PM +0100, Thomas Gleixner wrote:
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

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

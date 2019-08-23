Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbfHWJcC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 05:32:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N9RFau029188
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:32:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujd139cvg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:32:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 23 Aug 2019 10:31:58 +0100
Subject: Re: [PATCH net] s390/qeth: reject oversized SNMP requests
References: <20190823092923.8507-1-jwi@linux.ibm.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Fri, 23 Aug 2019 11:31:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190823092923.8507-1-jwi@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c0339d7f-2809-fe5a-57bf-2f76cee83eb0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Dan Carpenter <dan.carpenter@oracle.com>

+cc Dan

On 23.08.19 11:29, Julian Wiedmann wrote:
> Commit d4c08afafa04 ("s390/qeth: streamline SNMP cmd code") removed
> the bounds checking for req_len, under the assumption that the check in
> qeth_alloc_cmd() would suffice.
> 
> But that code path isn't sufficiently robust to handle a user-provided
> data_length, which could overflow (when adding the cmd header overhead)
> before being checked against QETH_BUFSIZE. We end up allocating just a
> tiny iob, and the subsequent copy_from_user() writes past the end of
> that iob.
> 
> Special-case this path and add a coarse bounds check, to protect against
> maliciuous requests. This let's the subsequent code flow do its normal
> job and precise checking, without risk of overflow.
> 
> Fixes: d4c08afafa04 ("s390/qeth: streamline SNMP cmd code")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index 9c3310c4d61d..6502b148541e 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -4374,6 +4374,10 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
>  	    get_user(req_len, &ureq->hdr.req_len))
>  		return -EFAULT;
>  
> +	/* Sanitize user input, to avoid overflows in iob size calculation: */
> +	if (req_len > QETH_BUFSIZE)
> +		return -EINVAL;
> +
>  	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
>  	if (!iob)
>  		return -ENOMEM;
> 

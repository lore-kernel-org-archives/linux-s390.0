Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44184 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHTQnK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 12:43:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so3543368pgl.11
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 09:43:09 -0700 (PDT)
Date: Tue, 20 Aug 2019 09:43:07 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [bug report] s390/qeth: streamline SNMP cmd code
Message-ID: <201908200941.93D8BB7B@keescook>
References: <20190820110504.GA1847@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820110504.GA1847@mwanda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jwi@linux.ibm.com, linux-s390@vger.kernel.org

On Tue, Aug 20, 2019 at 02:05:04PM +0300, Dan Carpenter wrote:
> [  Kees, could we make copy_from_user() just fail if size is more than
>    INT_MAX? ]

We already have similar limits in the VFS and other helpers. We might as
well do it in copy_*_user() too. Let me put together a patch...

-Kees

> 
> Hello Julian Wiedmann,
> 
> The patch d4c08afafa04: "s390/qeth: streamline SNMP cmd code" from
> Jun 27, 2019, leads to the following static checker warning:
> 
> 	drivers/s390/net/qeth_core_main.c:4381 qeth_snmp_command()
> 	error: check that 'req_len' is capped
> 
> drivers/s390/net/qeth_core_main.c
>   4355  static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
>   4356  {
>   4357          struct qeth_snmp_ureq __user *ureq;
>   4358          struct qeth_cmd_buffer *iob;
>   4359          unsigned int req_len;
>   4360          struct qeth_arp_query_info qinfo = {0, };
>   4361          int rc = 0;
>   4362  
>   4363          QETH_CARD_TEXT(card, 3, "snmpcmd");
>   4364  
>   4365          if (IS_VM_NIC(card))
>   4366                  return -EOPNOTSUPP;
>   4367  
>   4368          if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
>   4369              IS_LAYER3(card))
>   4370                  return -EOPNOTSUPP;
>   4371  
>   4372          ureq = (struct qeth_snmp_ureq __user *) udata;
>   4373          if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
>   4374              get_user(req_len, &ureq->hdr.req_len))
>   4375                  return -EFAULT;
>   4376  
>   4377          iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
> 
> The problem is that qeth_get_adapter_cmd() doesn't guard against integer
> overflows if reg_len is >= UINT_MAX - offsetof(struct qeth_ipacmd_setadpparms,
> data)).
> 
>   4378          if (!iob)
>   4379                  return -ENOMEM;
>   4380  
>   4381          if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
>   4382                             &ureq->cmd, req_len)) {
> 
> So then this copy_from_user() could overflow.  The original code had a
> similar problem but it only affect 32 bit systems.  I'm not sure what is
> a good upper bound for req_len.
> 
>   4383                  qeth_put_cmd(iob);
>   4384                  return -EFAULT;
>   4385          }
>   4386  
>   4387          qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
> 
> regards,
> dan carpenter

-- 
Kees Cook

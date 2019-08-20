Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:55210 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfHTLFO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Aug 2019 07:05:14 -0400
Date: Tue, 20 Aug 2019 14:05:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] s390/qeth: streamline SNMP cmd code
Message-ID: <20190820110504.GA1847@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: jwi@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Kees Cook <keescook@chromium.org>

[  Kees, could we make copy_from_user() just fail if size is more than
   INT_MAX? ]

Hello Julian Wiedmann,

The patch d4c08afafa04: "s390/qeth: streamline SNMP cmd code" from
Jun 27, 2019, leads to the following static checker warning:

	drivers/s390/net/qeth_core_main.c:4381 qeth_snmp_command()
	error: check that 'req_len' is capped

drivers/s390/net/qeth_core_main.c
  4355  static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
  4356  {
  4357          struct qeth_snmp_ureq __user *ureq;
  4358          struct qeth_cmd_buffer *iob;
  4359          unsigned int req_len;
  4360          struct qeth_arp_query_info qinfo = {0, };
  4361          int rc = 0;
  4362  
  4363          QETH_CARD_TEXT(card, 3, "snmpcmd");
  4364  
  4365          if (IS_VM_NIC(card))
  4366                  return -EOPNOTSUPP;
  4367  
  4368          if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
  4369              IS_LAYER3(card))
  4370                  return -EOPNOTSUPP;
  4371  
  4372          ureq = (struct qeth_snmp_ureq __user *) udata;
  4373          if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
  4374              get_user(req_len, &ureq->hdr.req_len))
  4375                  return -EFAULT;
  4376  
  4377          iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);

The problem is that qeth_get_adapter_cmd() doesn't guard against integer
overflows if reg_len is >= UINT_MAX - offsetof(struct qeth_ipacmd_setadpparms,
data)).

  4378          if (!iob)
  4379                  return -ENOMEM;
  4380  
  4381          if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
  4382                             &ureq->cmd, req_len)) {

So then this copy_from_user() could overflow.  The original code had a
similar problem but it only affect 32 bit systems.  I'm not sure what is
a good upper bound for req_len.

  4383                  qeth_put_cmd(iob);
  4384                  return -EFAULT;
  4385          }
  4386  
  4387          qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);

regards,
dan carpenter

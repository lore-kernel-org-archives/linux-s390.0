Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39316 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgFPLno (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 07:43:44 -0400
Subject: Re: [kvm-unit-tests PATCH v9 11/12] s390x: css: msch, enable test
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-12-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <665f6c4c-6e72-5980-a3c8-d6ca31ff470c@redhat.com>
Date: Tue, 16 Jun 2020 13:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-12-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 15/06/2020 11.32, Pierre Morel wrote:
> A second step when testing the channel subsystem is to prepare a channel
> for use.
> This includes:
> - Get the current subchannel Information Block (SCHIB) using STSCH
> - Update it in memory to set the ENABLE bit
> - Tell the CSS that the SCHIB has been modified using MSCH
> - Get the SCHIB from the CSS again to verify that the subchannel is
>   enabled.
> - If the command succeeds but subchannel is not enabled retry a
>   predefined retries count.
> - If the command fails, report the failure and do not retry, even
>   if cc indicates a busy/status pending as we do not expect this.
> 
> This tests the MSCH instruction to enable a channel succesfuly.

s/succesfuly/successfully/

> This some retries are done and in case of error, and if the retries
> count is exceeded, a report is made.

That sentence needs some fixes, too ;-)

With the commit description fixed:

Acked-by: Thomas Huth <thuth@redhat.com>

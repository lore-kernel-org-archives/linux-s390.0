Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58262 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbgG3LEN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jul 2020 07:04:13 -0400
Date: Thu, 30 Jul 2020 13:03:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: skrf: Add exception new
 skey test and add test to unittests.cfg
Message-ID: <20200730130358.6d0bf615.cohuck@redhat.com>
In-Reply-To: <20200727095415.494318-3-frankja@linux.ibm.com>
References: <20200727095415.494318-1-frankja@linux.ibm.com>
        <20200727095415.494318-3-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On Mon, 27 Jul 2020 05:54:14 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> When an exception new psw with a storage key in its mask is loaded
> from lowcore, a specification exception is raised. This differs from
> the behavior when trying to execute skey related instructions, which
> will result in special operation exceptions.
> 
> Also let's add the test unittests.cfg so it is run more often.

when you respin: s/add the test/add the test to/

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/skrf.c        | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  4 +++
>  2 files changed, 84 insertions(+)

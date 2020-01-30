Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727193AbgA3QXJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 11:23:09 -0500
Date: Thu, 30 Jan 2020 17:22:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 5/6] selftests: KVM: s390x: Add reset tests
Message-ID: <20200130172255.4b38c058.cohuck@redhat.com>
In-Reply-To: <20200130123434.68129-6-frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
        <20200130123434.68129-6-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Thu, 30 Jan 2020 07:34:33 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Test if the registers end up having the correct values after a normal,
> initial and clear reset.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile       |   1 +
>  tools/testing/selftests/kvm/s390x/resets.c | 157 +++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/resets.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727261AbgA3NDL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jan 2020 08:03:11 -0500
Date: Thu, 30 Jan 2020 14:03:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 4/6] selftests: KVM: Add fpu and one reg set/get
 library functions
Message-ID: <20200130140300.42fa74df.cohuck@redhat.com>
In-Reply-To: <20200130123434.68129-5-frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
        <20200130123434.68129-5-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org

On Thu, 30 Jan 2020 07:34:32 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Add library access to more registers.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  6 +++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 48 +++++++++++++++++++
>  2 files changed, 54 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

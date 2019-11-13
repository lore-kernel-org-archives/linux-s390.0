Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57329 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbfKMMfO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Nov 2019 07:35:14 -0500
Subject: Re: [PATCH v1 0/4] s390x: Testing the Subchannel I/O
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30d17ea4-1c35-f44a-8736-05725b251c69@redhat.com>
Date: Wed, 13 Nov 2019 13:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com

 Hi Pierre!

Meta-comment: Please use "[kvm-unit-tests PATCH ...]" in the subject for
future kvm-unit-tests patches.

On 13/11/2019 13.23, Pierre Morel wrote:
[...]
> The simple test tests the I/O reading by the SUB Channel. It needs QEMU t=
o
> be patched to have the pong device defined.

Are you going to send QEMU patches for this? I assume that's a
prerequisite for this patch series?

 Thomas

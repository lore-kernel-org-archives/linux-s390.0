Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgE0UXY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 16:23:24 -0400
Date: Wed, 27 May 2020 13:23:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v3 0/7] Statsfs: a new ram-based file system for Linux
 kernel statistics
Message-ID: <20200527132321.54bcdf04@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
References: <20200526110318.69006-1-eesposit@redhat.com>
        <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, David Rientjes <rientjes@google.com>, Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On Wed, 27 May 2020 15:14:41 +0200 Emanuele Giuseppe Esposito wrote:
> Regarding the config, as I said the idea is to gather multiple 
> subsystems' statistics, therefore there wouldn't be a single 
> configuration method like in netlink.
> For example in kvm there are file descriptors for configuration, and 
> creating them requires no privilege, contrary to the network interfaces.

Enumerating networking interfaces, addresses, and almost all of the
configuration requires no extra privilege. In fact I'd hope that
whatever daemon collects network stats doesn't run as root :)

I think enumerating objects is of primary importance, and statistics 
of those objects are subordinate.

Again, I have little KVM knowledge, but BPF also uses a fd-based API,
and carries stats over the same syscall interface.

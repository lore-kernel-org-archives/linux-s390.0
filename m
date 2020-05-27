Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WWA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 May 2020 18:22:00 -0400
Subject: Re: [PATCH v3 0/7] Statsfs: a new ram-based file system for Linux
 kernel statistics
References: <20200526110318.69006-1-eesposit@redhat.com>
 <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
 <20200527132321.54bcdf04@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <af2ba926-73bc-26c3-7ce7-bd45f657fd85@redhat.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <b6fa4439-c6b8-63a4-84fd-fbac3d4f10fd@gmail.com>
Date: Wed, 27 May 2020 16:21:55 -0600
MIME-Version: 1.0
In-Reply-To: <af2ba926-73bc-26c3-7ce7-bd45f657fd85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Jim Mattson <jmattson@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, David Rientjes <rientjes@google.com>, Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On 5/27/20 3:07 PM, Paolo Bonzini wrote:
> I see what you meant now.  statsfs can also be used to enumerate objects
> if one is so inclined (with the prototype in patch 7, for example, each
> network interface becomes a directory).

there are many use cases that have 100's to 1000's have network devices.
Having a sysfs entry per device already bloats memory usage for these
use cases; another filesystem with an entry per device makes that worse.
Really the wrong direction for large scale systems.

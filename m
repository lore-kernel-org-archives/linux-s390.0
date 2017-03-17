From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 02/16] s390: cio: export more interfaces
Date: Fri, 17 Mar 2017 10:29:31 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1703171027130.3003@schleppi>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com> <20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> Export the common I/O interfaces those are needed by an I/O
> subchannel driver to actually talk to the subchannel.

Which I/O subchannel driver are you talking about? I know of just one
and it can't be build as a module.

Sebastian

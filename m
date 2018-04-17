From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
Date: Tue, 17 Apr 2018 12:10:44 +0200
Message-ID: <20180417121044.5c8f2182.cohuck@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
        <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
        <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Harald Freudenberger <FREUDE@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, berrange@redhat.com, bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com, fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, Reinhard Buendgen <BUENDGEN@de.ibm.com>, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 17 Apr 2018 09:49:58 +0200
"Harald Freudenberger" <FREUDE@de.ibm.com> wrote:

> Didn't we say that when APXA is not available there is no Crypto support
> for KVM ?

[Going by the code, as I don't have access to the architecture]

Current status seems to be:
- setup crycb if facility 76 is available (that's MSAX3, I guess?)
- use format 2 if APXA is available, else use format 1

From Tony's patch description, the goal seems to be:
- setup crycb even if MSAX3 is not available

So my understanding is that we use APXA only to decide on the format of
the crycb, but provide it in any case?

(Not providing a crycb if APXA is not available would be loss of
functionality, I guess? Deciding not to provide vfio-ap if APXA is not
available is a different game, of course.)

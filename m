From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 3/8] s390: I/O interrupt and machine check
 injection.
Date: Mon, 10 Dec 2012 18:26:28 -0600
Message-ID: <1355185588.21015.1@driftwood>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-4-git-send-email-cornelia.huck@de.ibm.com>
	<82610216-94CA-44E8-B3CE-EB94886CECFC@suse.de>
	<20121210112726.0697bc4f@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20121210112726.0697bc4f@BR9GNB5Z> (from
	cornelia.huck@de.ibm.com on Mon Dec 10 04:27:26 2012)
Content-Disposition: inline
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

What do you actually use to run Linux under this target? There are some =20
leads at
http://virtuallyfun.superglobalmegacorp.com/?p=3D1206 which more or less =20
leads to
http://ftp.nl.debian.org/debian/dists/Debian6.0.6/main/installer-s390/curre=
nt/images/generic/ =20
but I dunno what qemu command line would go along with those files...

Any hints?

Rob=

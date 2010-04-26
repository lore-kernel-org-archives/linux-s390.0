Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BD58848.8090205@gmail.com>
Date: Mon, 26 Apr 2010 14:34:16 +0200
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
MIME-Version: 1.0
Subject: deadline ALWAYS default for dasd devices(s390) ?
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

hi,

why is it FORCED ? bypassing a GLOBAL setting and also the kernel command l=
ine !!!

drivers/s390/block/dasd.c

/*
 * Allocate and initialize request queue and default I/O scheduler.
 */
static int dasd_alloc_queue(struct dasd_block *block)
{
	int rc;

	block->request_queue =3D blk_init_queue(do_dasd_request,
					       &block->request_queue_lock);
	if (block->request_queue =3D=3D NULL)
		return -ENOMEM;

	block->request_queue->queuedata =3D block;

	elevator_exit(block->request_queue->elevator);
	block->request_queue->elevator =3D NULL;
	rc =3D elevator_init(block->request_queue, "deadline");
	if (rc) {
		blk_cleanup_queue(block->request_queue);
		return rc;
	}
	return 0;
}


-thanks-

--=20
=ABAll=E1 muevan feroz guerra, ciegos reyes por un palmo m=E1s de tierra;
que yo aqu=ED tengo por m=EDo cuanto abarca el mar brav=EDo, a quien nadie
impuso leyes. Y no hay playa, sea cualquiera, ni bandera de esplendor,
que no sienta mi derecho y d=E9 pecho a mi valor.=BB
